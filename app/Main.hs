{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ScopedTypeVariables #-}

module Main where

import DefaultMap ( lookup, DefaultMap (DefaultMap), lookup' )
import CsvLoader (FromSymbol, ToSymbol, initMappings, FileName)


import Main.Utf8 ( withUtf8 )

import qualified Data.Map as Map
import qualified Data.Text as T
import qualified Data.Text.Lazy as TL
import qualified Data.Text.IO as TIO
import qualified Data.String
import qualified Data.Vector as V
import qualified Data.ByteString.Lazy as BL

import qualified Data.ByteString as B
import qualified Data.Text.Encoding as TE
import qualified Data.Text.Lazy.Encoding as TEL

import Data.Csv ( encode,decode, HasHeader(NoHeader) )

-- | Set fileName
fileName :: FileName
fileName = "mappings.csv"

-- | Set defaultSymbol to a Space 
defaultSymbol :: ToSymbol
defaultSymbol = " "

-- | Load Mappings with default value 
loadMappingsWithDefault:: ToSymbol -> FileName -> IO (Either String (DefaultMap.DefaultMap FromSymbol ToSymbol))
loadMappingsWithDefault = initMappings

-- -- | Map multi-char string to text
-- getMappedLine :: String -> DefaultMap.DefaultMap FromSymbol ToSymbol ->  T.Text
-- getMappedLine str defaultMap = T.concat $ fmap (DefaultMap.lookup' defaultMap $ T.singleton) str


getMappedSymbolMsg :: FromSymbol -> IO()
getMappedSymbolMsg fromSymbol = withUtf8 $ do
    eitherMappings <- loadMappingsWithDefault defaultSymbol fileName
    case eitherMappings of
          Left err -> TIO.putStrLn "Something is wrong while reading the file"
          Right defaultMap -> TIO.putStrLn $ mconcat ["Char ", fromSymbol, " corresponds to ", result]
                             where result = DefaultMap.lookup fromSymbol defaultMap





main :: IO ()
main = do
    putStrLn "Please enter a line."
    str <- getLine
    -- myText <- fmap T.pack str

    -- Load the mappings with default symbol and file name
    let eitherMappings = loadMappingsWithDefault defaultSymbol fileName
    putStrLn "a"

    -- case eitherMappings of
    --     Left err -> TIO.putStrLn "Something is wrong while reading the file"
    --     Right defaultMap -> TIO.putStrLn $ mconcat ["Char ", fromSymbol, " corresponds to ", result]
    --                         where result = DefaultMap.lookup fromSymbol defaultMap


    -- let myMappedText = T.concat $ fmap (DefaultMap.lookup' eitherMappings $ T.pack) str
    -- TIO.putStrLn myMappedText

