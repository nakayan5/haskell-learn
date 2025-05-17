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
    ("add" : rest) ->
      loop (addTodo (unwords rest) todos)
    ("done" : i : _) ->
      case completeTodo (read i) todos of
        Right newTodos ->
          loop newTodos
        Left errMsg ->
          putStrLn ("error: " ++ errMsg) >> loop todos
    ("quit" : _) ->
      putStrLn "Goodbye!"
    _ ->
      putStrLn "Invalid command!" >> loop todos
