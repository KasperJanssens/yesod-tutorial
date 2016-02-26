{-# LANGUAGE ScopedTypeVariables #-}
module Handler.Worksheet where
import Import
import Text.Julius (RawJS (..))

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
  let dates = ["yesterday", "day before yesterday"] :: [Text]
  let (listDateId, hrefDateId, listCompanyId, hrefCompanyId, formId, timeListId) = ids
  defaultLayout $ do
    setTitle "Welcome To Worksheets GETTED!"
    $(widgetFile "worksheet")



postInputR :: Handler Html
postInputR = do
--    dateTime <- runInputPost $ ireq timeFieldTypeTime "dateTimePicker"
--    company <- runInputPost $ ireq (selectFieldList selectFields) "companyPicker"
--     let companies = ["amplidata", "amplidataloss"] :: [Text]
--     let dates = ["yesterday", "day before yesterday"] :: [Text]
    defaultLayout [whamlet|<p>koekoek
                           <p>merel
    |]


dayPicker :: Field Handler Day
dayPicker = dayField

ids :: (Text, Text, Text, Text, Text, Text)
ids = ("js-date-lis","js-date-a", "js-company-lis", "js-company-a", "js-form-id", "js-time-list-id")