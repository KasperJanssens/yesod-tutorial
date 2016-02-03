{-# LANGUAGE ScopedTypeVariables #-}
module Handler.Worksheet where
import Import

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
  defaultLayout $ do
    setTitle "Welcome To Worksheets GETTED!"
    $(widgetFile "worksheet")


postInputR :: Handler Html
postInputR = do
    dateTime <- runInputPost $ ireq timeFieldTypeTime "dateTimePicker"
    company <- runInputPost $ ireq (selectFieldList selectFields) "companyPicker"
    defaultLayout [whamlet|<p>#{show dateTime}
                           <p>#{show company}
    |]


