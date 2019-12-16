#!/usr/bin/env stack
-- stack script --resolver lts-12.10 --package bibtex --package parsec --package yaml --package unordered-containers

{-# LANGUAGE OverloadedStrings, RecordWildCards #-}

import Text.Parsec.String
import Text.BibTeX.Parse (file)
import Text.BibTeX.Entry
import System.Environment
import qualified Data.HashMap.Strict as HM
import Data.Yaml as Y
import Data.Maybe
import Data.List


readBibFile :: FilePath -> IO [T]
readBibFile = fmap (either (error . show) id) . parseFromFile file

instance Y.ToJSON T where
    toJSON Cons {..} =
        object
            [ "type" .= entryType
            , "identifier" .= identifier
            , "fields" .= HM.fromList fields
            ]


main :: IO ()
main = do
    [libFile, outputPath] <- getArgs
    entries <- readBibFile libFile
    let f =
            (`any` ["Adam, Justus", "Justus Adam"]) .
            flip isInfixOf . fromMaybe [] . lookup "Author" . fields
    let filtered = filter f entries
    Y.encodeFile outputPath filtered
