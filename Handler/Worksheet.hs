module Handler.Worksheet where
import Import
import Yesod.Form.Bootstrap3 (BootstrapFormLayout (..), renderBootstrap3)
import Data.Time.LocalTime

amplidata :: Company
amplidata = Company "amplidata" "niks"


selectFields:: [(Company, Company)]
selectFields = [(amplidata,amplidata)]
-- selectFields :: [(Text, Text)]
-- selectFields = []
-- selectFields = [("Value 1" :: Text, "value1"),("Value 2", "value2")]

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



-- dateForm2 :: Html -> MForm Handler (FormResult ((TimeOfDay,TimeOfDay), Company), Widget)
dateForm2 :: Html -> MForm Handler ((FormResult Company), Widget)
dateForm2 extra = do
  (comboRes, comboView) <- mreq (selectFieldList selectFields) "combo" Nothing
--   (fromRes, fromView) <- mreq timeFieldTypeTime "Choose start time" Nothing
--   (toRes, toView) <- mreq timeFieldTypeTime "Choose end time" Nothing
--   let fromToRes = (,) <$> fromRes <*> toRes
--   let fromToComboRes = (,) <$> fromToRes <*> comboRes
  let widget = do
          toWidget [whamlet|
              #{extra}
              <p> Today's work for
                  \ #
                  ^{fvInput comboView}
          |]
  return (comboRes, widget)

dateForm :: Form (TimeOfDay, TimeOfDay)
dateForm = renderBootstrap3 BootstrapBasicForm $ (,)
               <$> areq timeFieldTypeTime "Choose start time" Nothing
               <*> areq timeFieldTypeTime "Choose end time" Nothing

