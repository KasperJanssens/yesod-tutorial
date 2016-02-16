module Handler.Worksheet where
import Import
import Yesod.Form.Bootstrap3 (BootstrapFormLayout (..), renderBootstrap3)
import Data.Time.LocalTime

amplidata :: Company
amplidata = Company "amplidata" "niks"

selectFields:: [(Company, Company)]
selectFields = [(amplidata,amplidata)]

getWorksheetR :: Handler Html
getWorksheetR = do
--   (dateFormWidget, dateFormEnctype) <- generateFormPost dateForm
--   (companyFormWidget, companyFormEnctype) <- generateFormPost companyForm
  let companies = ["amplidata", "amplidataloss"] :: [Text]
  let dates = ["yesterday", "day before yesterday"] :: [Text]
  defaultLayout $ do
    setTitle "Welcome To Worksheets GETTED!"
    $(widgetFile "worksheet")

postWorksheetR :: Handler Html
postWorksheetR = do
--   ((dateResult, dateFormWidget), dateFormEnctype) <- runFormPostNoToken dateForm
--   ((companyResult, companyFormWidget), companyFormEnctype) <- runFormPostNoToken companyForm
  let companies = ["amplidata", "amplidataloss"] :: [Text]
  let dates = ["yesterday", "day before yesterday"] :: [Text]
--   print dateResult
--   print companyResult
  defaultLayout $ do
     setTitle "Welcome To Worksheets POSTED!"
     $(widgetFile "worksheet")


companyForm :: Form Company
companyForm = renderBootstrap3 BootstrapBasicForm $ areq (selectFieldList selectFields) "" Nothing

dateForm :: Form  TimeOfDay
dateForm = renderBootstrap3 BootstrapBasicForm $  areq timeFieldTypeTime "" Nothing

dayPicker :: Field Handler Day
dayPicker = dayField

