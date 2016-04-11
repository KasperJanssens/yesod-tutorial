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
  req <- getRequest
  let token =
          case reqToken req of
              Nothing -> "lebberlebber"
              Just n -> n
  let companies = ["amplidata", "amplidataloss"] :: [Text]
  let dates = ["today's", "yesterday's", "day before yesterday's"] :: [Text]
  let (listDateId, hrefDateId, listCompanyId,
       hrefCompanyId, startLogging, selectWorklog, selectTime, selectCompany,
       timeListId, voegToe) = ids
  defaultLayout $ do
    setTitle "Welcome To Worksheets"
    $(widgetFile "worksheet")


postWorksheetR :: Handler Value
postWorksheetR = undefined


postInputR :: Handler Value
postInputR = do
    _input <- requireJsonBody :: Handler Input
    zonedTime <- liftIO getZonedTime
    let _zonedDay = localDay . zonedTimeToLocalTime $ zonedTime
    returnJson ("<li><input type='time'/></li>"::Text)



dayPicker :: Field Handler Day
dayPicker = dayField

timePicker :: Field Handler TimeOfDay
timePicker = timeFieldTypeText

ids :: (Text, Text, Text, Text, Text, Text, Text, Text, Text, Text)
ids = ("js-date-lis","js-date-a", "js-company-lis", "js-company-a", "js-form-id", "selectWorklog",
       "selectTime", "selectCompany", "js-time-list-id", "voeg-toe")