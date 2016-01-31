module Worksheet.Contract where

import Worksheet.Company
import Data.Time.Calendar

data Contract = Contract {
  from::Day,
  to::Day,
  company::Company
}