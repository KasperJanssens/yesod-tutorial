module Handler.Worksheet where
import Import
import Yesod.Form.Bootstrap3 (BootstrapFormLayout (..), renderBootstrap3)
import Data.Time.LocalTime

getWorksheetR :: Handler Html
getWorksheetR = do
  (formWidget, formEnctype) <- generateFormPost dateForm
  defaultLayout $ do
      aDomId <- newIdent
      setTitle "Welcome To Worksheets!"
      $(widgetFile "worksheet")

postWorksheetR :: Handler Html
postWorksheetR = undefined

dateForm :: Form (TimeOfDay, TimeOfDay)
dateForm = renderBootstrap3 BootstrapBasicForm $ (,)
               <$> areq timeFieldTypeTime "Choose start time" Nothing
               <*> areq timeFieldTypeTime "Choose end time" Nothing

