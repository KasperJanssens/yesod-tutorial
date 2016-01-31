module Worksheet.Company where
import Data.Text
import Data.Eq
import Data.Function
import Yesod

data Company = Company {
  companyName::Text,
  vatNumber::Text
}

instance Eq Company where
  (==) = (==) `on` companyName

instance RenderMessage master Company where
  renderMessage _ _  = companyName