import Network.HTTP.Browser


main =
  browse $ do
    setAuthorityGen (\_ _ → const ("username", "password"))
    request $ getRequest "http://github.com"
