import Network.Browser


main =
  browse $ do
    setAuthorityGen (\_ _ -> return $ Just ("username", "password"))
    request $ getRequest "http://github.com"
