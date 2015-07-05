pathSpec :: Spec
pathSpec = do
  describe "[function] isPathLine" $ do
    it "returns true if the line starts with \"PATH=\"" $
      isPathLine "PATH=/usr/bool" `shouldBe` True
    it "returns true if the line starts with \"path=\"" $
      isPathLine "path=/another/path" `shouldBe` True
    it "rejects a string not containing PATH=" $
      isPathLine "my/string" `shouldBe` False
    it "rejects the empty string" $
      isPathLine "" `shouldBe` False
    it "rejects any random string containing \"PATH=\"" $
      isPathLine "my/PATH=/some" `shouldBe` False

  describe "[function] alterMaybe" $ do
    let testLines = ["", "hello", "halko", "hello"]
    it "alters a line matching the predicate" $
      maybe False (elem "hello") (alterMaybe (== "hello") (const "goodbye") testLines) `shouldBe` True
    it "alters the first ocurrence only" $
      maybe False ((== "hello") . (!! 3)) (alterMaybe (== "hello") (const "goodbye") testLines) `shouldBe` True
    it "fails if the predicate matches nothing" $
      alterMaybe (== "some") (const "") testLines `shouldBe` Nothing
