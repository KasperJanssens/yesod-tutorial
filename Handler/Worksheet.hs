module Handler.Worksheet where
import Import
import Yesod.Form.Bootstrap3 (BootstrapFormLayout (..), renderBootstrap3)
import Data.Time.LocalTime

getWorksheetR :: Handler Html
getWorksheetR = do
  ((_result, formWidget), formEnctype) <- runFormGet dateForm2
  defaultLayout $ do
    setTitle "Welcome To Worksheets!"
    $(widgetFile "worksheet")

postWorksheetR :: Handler Html
postWorksheetR = do
  ((_result, formWidget), formEnctype) <- runFormPost dateForm2
  defaultLayout $ do
     setTitle "Welcome To Worksheets!"
     $(widgetFile "worksheet")



dateForm2 :: Html -> MForm Handler (FormResult (TimeOfDay,TimeOfDay), Widget)
dateForm2 extra = do
  let companyComboBox = selectFieldList [("Hey", "Hey"); ("Yow", "Yow)"]
  (fromRes, fromView) <- mreq timeFieldTypeTime "Choose start time" Nothing
  (toRes, toView) <- mreq timeFieldTypeTime "Choose end time" Nothing
  let fromToRes = (,) <$> fromRes <*> toRes
  let widget = do
          toWidget [whamlet|
              #{extra}
              <p>
                  #
                  ^{fvInput fromView}
                  \ #
                  ^{fvInput toView}
          |]
  return (fromToRes, widget)

dateForm :: Form (TimeOfDay, TimeOfDay)
dateForm = renderBootstrap3 BootstrapBasicForm $ (,)
               <$> areq timeFieldTypeTime "Choose start time" Nothing
               <*> areq timeFieldTypeTime "Choose end time" Nothing

