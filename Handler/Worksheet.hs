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
  ((_result, dateFormWidget), dateFormEnctype) <- runFormGet dateForm
  ((_result, companyFormWidget), companyFormEnctype) <- runFormGet companyForm
  defaultLayout $ do
    setTitle "Welcome To Worksheets!"
    $(widgetFile "worksheet")

postWorksheetR :: Handler Html
postWorksheetR = do
  ((_result, dateFormWidget), dateFormEnctype) <- runFormPost dateForm
  ((_result, companyFormWidget), companyFormEnctype) <- runFormGet companyForm
  defaultLayout $ do
     setTitle "Welcome To Worksheets!"
     $(widgetFile "worksheet")


companyForm :: Form Company
companyForm = renderBootstrap3 BootstrapBasicForm $ areq (selectFieldList selectFields) "" Nothing

dateForm :: Form  TimeOfDay
dateForm = renderBootstrap3 BootstrapBasicForm $  areq timeFieldTypeTime "" Nothing

