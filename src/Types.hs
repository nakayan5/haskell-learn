{-# LANGUAGE DeriveGeneric #-}

module Types where

import Data.Aeson (FromJSON, ToJSON)
import qualified Data.Text as T
import GHC.Generics (Generic)

data Person = Person
  { name :: T.Text,
    age :: Int
  }
  deriving (Show, Generic)

-- Person は FromJSON 型クラスのインスタンス
instance FromJSON Person

-- Person は ToJSON 型クラスのインスタンス
instance ToJSON Person

data Summary = Summary
  { names :: [T.Text],
    averageAge :: Double
  }
  deriving (Show, Generic)

instance ToJSON Summary
