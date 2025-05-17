module Main where

import Data.Aeson (decodeFileStrict', encodeFile)
import Transformer (summarize)

main :: IO ()
main = do
  mPeople <- decodeFileStrict' "input.json"
  case mPeople of
    Just people -> do
      let summary = summarize people
      encodeFile "output.json" summary
      putStrLn "変換完了！"
    Nothing -> putStrLn "JSONの読み込みに失敗しました"
