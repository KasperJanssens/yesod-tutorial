{-# LANGUAGE FlexibleInstances #-}

module Model where

import ClassyPrelude.Yesod
import Database.Persist.Quasi

-- You can define all of your database entities in the entities file.
-- You can find more information on persistent and how to declare entities
-- at:
-- http://www.yesodweb.com/book/persistent/
share [mkPersist sqlSettings, mkMigrate "migrateAll"]
    $(persistFileWith lowerCaseSettings "config/models")

-- TODO : meerdere persist files in één app, gaat dat (namespacing)?
-- dependencies?

instance Eq Company where
--      (==) = undefined
  (==) = (==) `on` companyName

instance RenderMessage master Company where
--      renderMessage _ _ = undefined
  renderMessage _ _  = companyName
