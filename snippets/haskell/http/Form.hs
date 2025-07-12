import Network.HTTP.Browser


main =
  browse $
    formToRequest $
      Form
        POST
        (fromJust $ parseURI "http://github.com/register/new")
        [ ("name", "Guido")
        , ("occupation", "Plumber")
        , ("email", "guido@python.org")
        ]
