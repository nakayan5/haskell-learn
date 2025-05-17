{-# LANGUAGE OverloadedStrings #-}

module Main where

import Data.Aeson (encode, object, (.=))
-- import qualified Data.ByteString.Lazy.Char8 as BL
import Network.HTTP.Types (status200)
import Network.Wai (Application, responseLBS)
import Network.Wai.Handler.Warp (run)

main :: IO ()
main = do
  putStrLn "Server running on http://localhost:8080"
  run 8080 app

app :: Application
app _req respond = do
  let json = encode $ object ["message" .= ("Hello, World!" :: String)]
  respond $ responseLBS status200 [("Content-Type", "application/json")] json
