import Control.Applicative

{-|
  This function will take an int and return a tuple with the Int * 7 and the Int + 2
-}
processInt :: Int -> (Int, Int)
processInt = pure (,) -- the 2-tuple constructor
  <*> (*7)
  <*> (+2)

-- processInt 4 = (28, 6)


data Hello = Hello {message :: String, sender :: String, date :: Int}

getMetaInfo :: Hello -> (String, Int)
getMetaInfo = pure (,)
  <*> sender
  <*> date
  
-- getMetaInfo (Hello "Hello World" "Jim" 98077) = ("Jim", 98077) 
