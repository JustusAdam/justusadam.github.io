import Network.HTTP.Browser


main =
  browse $
    request $ getRequest "http://github.com"
