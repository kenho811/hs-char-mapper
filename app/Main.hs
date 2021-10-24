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

-- | Map multi-char string to text
-- Steps are (a) convert each char to text, (b) find correspoding symbol, (c) strip all white space.
-- (d) concat all texts in a list back together
getMappedLine :: String -> DefaultMap.DefaultMap FromSymbol ToSymbol ->  T.Text
getMappedLine str defaultMap = T.concat $ fmap (T.strip . DefaultMap.lookup' defaultMap . T.singleton) str


-- | For testing mapping symbols
getMappedSymbolMsg :: FromSymbol -> IO()
getMappedSymbolMsg fromSymbol = withUtf8 $ do
    eitherMappings <- loadMappingsWithDefault defaultSymbol fileName
    case eitherMappings of
          Left err -> TIO.putStrLn "Something is wrong while reading the file"
          Right defaultMap -> TIO.putStrLn $ mconcat ["Char ", fromSymbol, " corresponds to ", result]
                             where result = DefaultMap.lookup fromSymbol defaultMap


main :: IO ()
main = do
    putStrLn ">>>Please enter a line."
    str <- getLine

    -- Load the mappings with default symbol and file name
    eitherMappings <- loadMappingsWithDefault defaultSymbol fileName

    putStrLn ">>>Output:"
    case eitherMappings of
        Left err -> TIO.putStrLn "Something is wrong while reading the file"
        Right defaultMap -> TIO.putStrLn result
                            where result = getMappedLine str defaultMap

    putStrLn ">>>Press enter to close"
    nul <- getLine
    putStrLn "bye"
