module Handler.Test2 where

import Import
import Yesod.Form.Bootstrap3 (BootstrapFormLayout (..), renderBootstrap3,
                              withSmallInput)
import qualified Handler.Worksheet as Worksheet
import Text.Julius (RawJS (..))



specialSelector :: (RenderMessage site FormMessage) =>
                     [Text] -> Field (HandlerT site IO) [Text]
specialSelector dates = Field
  { fieldParse = \texts _ -> return $ Right . Just $ texts,
    fieldView = \selectId name _attrs _val _isReq ->
      let hrefDateId = selectId ++ "Href" in
      let listDateId = selectId ++ "ListDate" in
      [whamlet|
      <span ##{selectId}>
          <a ##{hrefDateId} href="#" name=#{name}>today
          <div ##{listDateId}>
              <ul>
                  $forall date <- dates
                      <li>#{date}
      |],
    fieldEnctype = UrlEncoded

}

test2Form :: Form ([Text])
test2Form = renderBootstrap3 BootstrapBasicForm $ do
   let fieldSettings = FieldSettings (fromString "") Nothing (Just "selectCompany") (Just "deNaam") []
   areq (specialSelector ["koekoek", "merel"]) fieldSettings Nothing

test2FormId :: Text
test2FormId = "testFormId"

(listDateId, hrefDateId, listCompanyId,
             hrefCompanyId, startLogging, selectWorklog, selectTime, selectCompany,
             timeListId, voegToe) = Worksheet.ids

getTest2R :: Handler Html
getTest2R = do
  (test2FormWidget, _formEnctype) <- generateFormPost test2Form
  defaultLayout $ do
    setTitle "Welcome To Yesod!"
    $(widgetFile "test2")



postTest2R :: Handler Html
postTest2R = do
  ((result, test2FormWidget), _formEnctype) <- runFormPost test2Form
  let tekst = case result of
                  FormSuccess s -> s
                  _ -> (["failure"] :: [Text])

  liftIO $ print ("den tekst is" :: Text)
  liftIO $ print tekst
  defaultLayout $ do
      setTitle "Welcome To Yesod!"
      $(widgetFile "test2")