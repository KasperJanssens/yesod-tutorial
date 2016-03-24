module Handler.Test where

import Import
import Yesod.Form.Bootstrap3 (BootstrapFormLayout (..), renderBootstrap3,
                              withSmallInput)
import Text.Julius (RawJS (..))

testForm :: Form ([Text])
testForm = renderBootstrap3 BootstrapBasicForm $
   areq textFieldList "" Nothing

textFieldList :: (RenderMessage site FormMessage) =>
                  Field (HandlerT site IO) [Text]
textFieldList = Field
  {
    fieldParse = \texts _ ->
      do
        print "veldje geparsed"
        return $ Right . Just $ texts ,
    fieldView = \theId name attrs val isReq ->
      let zipUp = zip ([1..]::[Int]) in
      [whamlet|
      <p> Dit is de lijst
      <ul>
      $case val
        $of Left errMsg
          <li>
            <p> twas ne left
            <input id=#{theId}-1 *{attrs} type=text name=#{name} value=#{errMsg} checked>
        $of Right textVals
          $forall (idPostFix, textVal) <- zipUp textVals
            <li>
              <p> twas ne right
              <input id=#{theId}-#{idPostFix} *{attrs} type=text name=#{name} value=#{textVal} checked>
      |]
    ,
    fieldEnctype = UrlEncoded
  }

getTestR :: Handler Html
getTestR = do
    (testFormWidget, formEnctype) <- generateFormPost testForm
    let testFormId = ("testFormId"::Text)
    defaultLayout $ do
        setTitle "Welcome To Yesod!"
        $(widgetFile "test")