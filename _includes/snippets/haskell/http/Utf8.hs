{-# LANGUAGE OverloadedStrings #-}

import Data.Text.Lazy
import Data.Text.Lazy.Encoding


warpApplication respond request =
  respond $ respondLBS $ encodeUtf8 "{\"text\": \"My json response\"}"
