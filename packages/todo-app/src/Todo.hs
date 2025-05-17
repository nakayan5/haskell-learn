module Todo where

import Control.Monad (when)

data Todo = Todo
  { title :: String,
    done :: Bool
  }
  deriving (Show)

type TodoList = [Todo]

data TodoError
  = IndexTooSmall
  | IndexTooLarge
  | TaskAlreadyDone
  | TaskNotFound
  deriving (Show)

-- タスクを追加する
addTodo :: String -> TodoList -> TodoList
addTodo t todos = todos ++ [Todo t False]

-- タスクを完了する
completeTodo :: Int -> TodoList -> Either TodoError TodoList
completeTodo idx todos = do
  when (idx < 0) $
    Left IndexTooSmall

  when (idx >= length todos) $
    Left IndexTooLarge

  let (before, rest) = splitAt idx todos

  case rest of
    [] -> Left TaskNotFound
    (t : after) -> do
      when (done t) $
        Left TaskAlreadyDone
      return (before ++ [t {done = True}] ++ after)

-- タスクリストを文字列に変換
formatTodos :: TodoList -> String
formatTodos = unlines . zipWith format [0 ..]
  where
    format :: Int -> Todo -> String
    format i (Todo t d) =
      show i ++ ". [" ++ (if d then "x" else " ") ++ "] " ++ t
