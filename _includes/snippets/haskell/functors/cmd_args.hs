data CallOptions = CallOptions {
    outputFile   :: Maybe String,
    inputFile    :: String,
    outputFormat :: String
  } deriving (Show)

instance Options CallOptions where
  defineOptions = pure CallOptions
    <*> defineOption (optionType_maybe optionType_string) (\o -> o {
        optionLongFlags   = ["output-file"],
        optionShortFlags  = "o",
        optionDescription = "print output to this file instead of stdout",
        optionDefault     = Nothing
      })
    <*> defineOption optionType_string (\o -> o {
        optionDefault     = stdFileName,
        optionLongFlags   = ["input-file"],
        optionShortFlags  = "i",
        optionDescription = "read input from this file"
      })
    <*> defineOption optionType_string (\o -> o {
        optionDefault     = outputFormatDefault,
        optionLongFlags   = ["output-format"],
        optionShortFlags  = "f",
        optionDescription = "set the output format"
      })