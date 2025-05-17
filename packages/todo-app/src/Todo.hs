module Todo where

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
completeTodo :: Int -> TodoList -> Maybe TodoList
completeTodo idx todos =
  if idx >= 0 && idx < length todos
    then
      let (before, rest) = splitAt idx todos
       in case rest of
            (t : after) -> Just (before ++ [t {done = True}] ++ after)
            [] -> Nothing
    else Nothing

-- タスクリストを文字列に変換
formatTodos :: TodoList -> String
formatTodos = unlines . zipWith format [0 ..]
  where
    format :: Int -> Todo -> String
    format i (Todo t d) =
      show i ++ ". [" ++ (if d then "x" else " ") ++ "] " ++ t
