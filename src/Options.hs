module Options (Options (..), parseOptions) where

import Options.Applicative

-- 引数の型定義
data Options = Options
  { optInput :: FilePath,
    optOutput :: FilePath
  }

-- パーサー定義
optionsParser :: Parser Options
optionsParser =
  Options
    <$> strOption
      ( long "input"
          <> short 'i'
          <> metavar "INPUT"
          <> help "Input JSON file"
      )
    <*> strOption
      ( long "output"
          <> short 'o'
          <> metavar "OUTPUT"
          <> help "Output JSON file"
      )

-- 実行用のラッパー
parseOptions :: IO Options
parseOptions = execParser opts
  where
    opts =
      info
        (optionsParser <**> helper)
        ( fullDesc
            <> progDesc "Transform JSON file structure"
            <> header "json-transformer - a CLI JSON converter"
        )
