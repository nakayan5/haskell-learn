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
completeTodo :: Int -> TodoList -> Either String TodoList
completeTodo idx todos
  | idx < 0 = Left "インデックスは0以上である必要があります。"
  | idx >= length todos = Left "インデックスが範囲外です。"
  | otherwise =
      let (before, rest) = splitAt idx todos
       in case rest of
            (t : after) -> Right (before ++ [t {done = True}] ++ after)
            [] -> Left "タスクが見つかりません。"

-- タスクリストを文字列に変換
formatTodos :: TodoList -> String
formatTodos = unlines . zipWith format [0 ..]
  where
    format :: Int -> Todo -> String
    format i (Todo t d) =
      show i ++ ". [" ++ (if d then "x" else " ") ++ "] " ++ t
