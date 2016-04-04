module Handler.Test where

import Import
import Yesod.Form.Bootstrap3 (BootstrapFormLayout (..), renderBootstrap3,
                              withSmallInput)
import Text.Julius (RawJS (..))

testForm :: Form ([Text])
testForm = renderBootstrap3 BootstrapBasicForm $ do
   let fieldSettings = FieldSettings (fromString "") Nothing Nothing (Just "deNaam") []
   areq textFieldList fieldSettings Nothing

textFieldList :: (RenderMessage site FormMessage) =>
                  Field (HandlerT site IO) [Text]
textFieldList = Field
  {
    fieldParse = \texts _ ->
      do
        return $ Right . Just $ texts ,
    fieldView = \theId name attrs val isReq ->
      let zipUp = zip ([1..]::[Int]) in
      [whamlet|
      <p> Dit is de lijst
      <button id="#{voegToe}"> voeg toe
      <ul id="#{ulId}">
        $case val
          $of Left errMsg
            <li>
              <input id=#{theId}-7 *{attrs} type=text name=#{name} value=#{errMsg} checked>
            <li>
              <input id=#{theId}-8 *{attrs} type=text name=#{name} value=#{errMsg} checked>
            <li>
              <input id=#{theId}-9 *{attrs} type=text name=#{name} value=#{errMsg} checked>
          $of Right textVals
            $forall (idPostFix, textVal) <- zipUp textVals
              <li>
                <input id=#{theId}-#{idPostFix} *{attrs} type=text name=#{name} value=#{textVal} checked>
      |]
    ,
    fieldEnctype = UrlEncoded
  }

testFormId = ("testFormId"::Text)

voegToe = ("voegEensEenTextekeToe"::Text)

ulId = ("ulleke"::Text)


getTestR :: Handler Html
getTestR = do
    (testFormWidget, formEnctype) <- generateFormPost testForm
    defaultLayout $ do
        setTitle "Welcome To Yesod!"
        $(widgetFile "test")

-- The POST handler processes the form. If it is successful, it displays the
-- parsed person. Otherwise, it displays the form again with error messages.
postTestR :: Handler Html
postTestR = do
    ((result, testFormWidget), enctype) <- runFormPost testForm
    case result of
        FormSuccess texties -> defaultLayout [whamlet| $forall text <- texties
                                                             <p> #{text}
                                                |]
        _ -> defaultLayout $ do
                 setTitle "Let's try again"
                 $(widgetFile "test")