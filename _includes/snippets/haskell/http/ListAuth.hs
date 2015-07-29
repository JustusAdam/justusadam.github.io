import HTTP.Browser


authList =
  [ (fromJust $ parseURI "http://google.com", ("walter", "12.24.1975"))
  , (fromJust $ parseURI "http://facebook.com", ("MarkZucherberg", "IamTheFounder"))
  , (fromJust $ parseURI "https://reddit.com", ("Stephenhawking", "BlackHole"))
  ]


main =
  browse $ do
    setAuthorityGen (\uri _ → return $ lookup uri authList)
    request $ getRequest "http://github.com"
