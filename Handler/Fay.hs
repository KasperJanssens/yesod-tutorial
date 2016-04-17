{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE DeriveDataTypeable #-}
module Handler.Fay where

import Fay.Convert (readFromFay)
import Import
import Prelude     ((!!))
import Yesod.Fay
import Data.Data

fibs :: [Int]
fibs = 0 : 1 : zipWith (+) fibs (drop 1 fibs)


data Command = GetFib Int (Returns Int)
    deriving (Typeable, Data)

onCommand :: CommandHandler App
onCommand render command =
    case readFromFay command of
      Just (GetFib index r) -> render r $ fibs !! index
      Nothing               -> invalidArgs ["Invalid command"]