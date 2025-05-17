module Main where

import Data.Aeson (decodeFileStrict', encodeFile)
import Options (Options (..), parseOptions)
import Transformer (summarize)
import Types ()

main :: IO ()
main = do
  Options {optInput = input, optOutput = output} <- parseOptions

  mPeople <- decodeFileStrict' input
  case mPeople of
    Just people -> do
      let summary = summarize people
      encodeFile output summary
      putStrLn $ "変換完了！→ " ++ output
    Nothing -> putStrLn "JSONの読み込みに失敗しました"
