{-# LANGUAGE LambdaCase #-}

module Main where

import Control.Monad.Except
import Control.Monad.IO.Class (liftIO)
import System.IO (hFlush, stdout)
import Text.Read (readMaybe)
import Todo

-- アプリケーション本体
main :: IO ()
main =
  runExceptT (loop []) >>= \case
    Left err -> putStrLn $ "エラー: " ++ renderError err
    Right () -> return ()

-- メインループ（ExceptT版）
loop :: TodoList -> ExceptT TodoError IO ()
loop todos = do
  liftIO $ do
    putStrLn "\n== ToDo List =="
    putStrLn (formatTodos todos)
    putStr "Command (add <task> | done <index> | quit): "
    hFlush stdout

  input <- liftIO getLine
  case words input of
    ("add" : rest) -> do
      let newTodos = addTodo (unwords rest) todos
      loop newTodos
    ("done" : i : _) ->
      case readMaybe i of
        Just idx -> do
          newTodos <- liftEither (completeTodo idx todos)
          loop newTodos
        Nothing -> do
          liftIO $ putStrLn "インデックスには数値を入力してください。"
          loop todos
    ("quit" : _) ->
      liftIO $ putStrLn "Goodbye!"
    _ -> do
      liftIO $ putStrLn "不正なコマンドです。"
      loop todos

-- エラーの説明を文字列に変換する関数
renderError :: TodoError -> String
renderError IndexTooSmall = "インデックスが小さすぎます。0以上にしてください。"
renderError IndexTooLarge = "インデックスが大きすぎます。存在するタスクの範囲内にしてください。"
renderError TaskAlreadyDone = "そのタスクはすでに完了済みです。"
renderError TaskNotFound = "指定されたタスクが見つかりません。"
