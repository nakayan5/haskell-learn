module Todo where

import Control.Monad (when)

data Todo = Todo
  { title :: String,
    done :: Bool
  }
  deriving (Show)

type TodoList = [Todo]

-- タスクを追加する
addTodo :: String -> TodoList -> TodoList
addTodo t todos = todos ++ [Todo t False]

-- タスクを完了する
completeTodo :: Int -> TodoList -> Either String TodoList
completeTodo idx todos = do
  when (idx < 0) $
    Left "インデックスは0以上でなければなりません"

  when (idx >= length todos) $
    Left "インデックスが範囲外です"

  let (before, rest) = splitAt idx todos

  case rest of
    [] -> Left "想定外のエラー：タスクが存在しません"
    (t : after) -> do
      when (done t) $
        Left "すでに完了済みのタスクです"
      return (before ++ [t {done = True}] ++ after)

-- タスクリストを文字列に変換
formatTodos :: TodoList -> String
formatTodos = unlines . zipWith format [0 ..]
  where
    format :: Int -> Todo -> String
    format i (Todo t d) =
      show i ++ ". [" ++ (if d then "x" else " ") ++ "] " ++ t
