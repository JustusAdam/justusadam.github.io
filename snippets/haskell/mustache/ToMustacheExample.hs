{-# LANGUAGE NamedFieldPuns    #-}
{-# LANGUAGE OverloadedStrings #-}
data Person = Person
  { name :: String
  , age :: Int
  , address :: Address
  }

instance ToJSON Address where ...

instance ToMustache Person where
  toMustache (Person { name, age, address }) =
    object
      [ "name"    ~> name
      , "age"     ~> age
      , "address" ~= address
      ]
