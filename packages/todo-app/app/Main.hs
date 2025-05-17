module Main where

import System.IO (hFlush, stdout)
import Todo

main :: IO ()
main = loop []

loop :: TodoList -> IO ()
loop todos = do
  putStrLn "\n== ToDo List =="
  putStrLn (formatTodos todos)
  putStr "Command (add <task> | done <index> | quit): "
  hFlush stdout
  input <- getLine
  case words input of
    ("add" : rest) -> do
      let newTodos = addTodo (unwords rest) todos
      loop newTodos
    ("done" : i : _) ->
      case reads i of
        [(n, "")] ->
          case completeTodo n todos of
            Right newTodos -> loop newTodos
            Left err -> do
              putStrLn ("Error: " ++ renderError err)
              loop todos
        _ -> do
          putStrLn "Error: 数字のインデックスを指定してください"
          loop todos
    ("quit" : _) ->
      putStrLn "Goodbye!"
    _ -> do
      putStrLn "Invalid command!"
      loop todos

-- エラーの説明を文字列に変換する関数
renderError :: TodoError -> String
renderError IndexTooSmall = "インデックスが小さすぎます。0以上にしてください。"
renderError IndexTooLarge = "インデックスが大きすぎます。存在するタスクの範囲内にしてください。"
renderError TaskAlreadyDone = "そのタスクはすでに完了済みです。"
renderError TaskNotFound = "指定されたタスクが見つかりません。"
