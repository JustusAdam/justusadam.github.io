{-# LANGUAGE OverloadedStrings #-}

import Data.Text.Lazy
import Data.Text.Lazy.Encoding
import Network.Warp


warpApplication respond request =
  respond $ respondLBS $ encodeUtf8 "{\"text\": \"My json response\"}"


main = run warpApplication
