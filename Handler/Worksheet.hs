{-# LANGUAGE ScopedTypeVariables #-}
module Handler.Worksheet where
import Import
import Text.Julius (RawJS (..))
import Data.Time.LocalTime

amplidata :: Company
amplidata = Company "amplidata" "niks"

selectFields:: [(Company, Company)]
selectFields = [(amplidata,amplidata)]

getWorksheetR :: Handler Html
getWorksheetR = do
--   (dateFormWidget, dateFormEnctype) <- generateFormPost dateForm
--   (companyFormWidget, companyFormEnctype) <- generateFormPost companyForm
  req <- getRequest
  let token =
          case reqToken req of
              Nothing -> "lebberlebber"
              Just n -> n
  let companies = ["amplidata", "amplidataloss"] :: [Text]
  let dates = ["today's", "yesterday's", "day before yesterday's"] :: [Text]
  let (listDateId, hrefDateId, listCompanyId,
       hrefCompanyId, startLogging, selectWorklog, selectTime, selectCompany,
       timeListId) = ids
  defaultLayout $ do
    setTitle "Welcome To Worksheets"
    $(widgetFile "worksheet")



postInputR :: Handler Html
postInputR = do
--    dateTime <- runInputPost $ ireq timeFieldTypeTime "dateTimePicker"
--    company <- runInputPost $ ireq (selectFieldList selectFields) "companyPicker"
--     let companies = ["amplidata", "amplidataloss"] :: [Text]
--     let dates = ["yesterday", "day before yesterday"] :: [Text]
    input <- (requireJsonBody :: Handler Input)
    print $ inputDate input
    print $ inputCompany input
    defaultLayout [whamlet|
                            <li><input type='time'/></li>
    |]


dayPicker :: Field Handler Day
dayPicker = dayField

timePicker :: Field Handler TimeOfDay
timePicker = timeFieldTypeText

ids :: (Text, Text, Text, Text, Text, Text, Text, Text, Text)
ids = ("js-date-lis","js-date-a", "js-company-lis", "js-company-a", "js-form-id", "selectTime",
       "selectCompany", "selectTime", "js-time-list-id")