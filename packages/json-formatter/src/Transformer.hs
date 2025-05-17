module Transformer (summarize) where

import Types (Person (age, name), Summary (..))

summarize :: [Person] -> Summary
summarize ps =
  Summary
    { names = map name ps,
      averageAge = avg (map age ps)
    }
  where
    avg xs = fromIntegral (sum xs) / fromIntegral (length xs)
