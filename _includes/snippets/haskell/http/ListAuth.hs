import HTTP.Browser
import Control.Arrow (second)


authList = map (second (fromJust . parseURI))  -- makes the strings into URI's
  [ ("http://google.com"  , ("walter", "12.24.1975"))
  , ("http://facebook.com", ("MarkZuckerberg", "IamTheFounder"))
  , ("http://reddit.com"  , ("StephenHawking", "BlackHole"))
  ]


main =
  browse $ do
    setAuthorityGen (const . return . flip lookup authList)
    request $ getRequest "http://github.com"
