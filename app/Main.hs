{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ScopedTypeVariables #-}

module Main where

import DefaultMap ( lookup, DefaultMap (DefaultMap) )
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

fileName :: FileName
fileName = "mappings.csv"


loadMappings :: FileName -> IO (Either String (DefaultMap.DefaultMap FromSymbol ToSymbol))
loadMappings = initMappings

getMappedSymbolMsg :: IO()
getMappedSymbolMsg = withUtf8 $ do
    myText <- fmap T.pack getLine
    eitherMappings <- loadMappings "mappings.csv"
    case eitherMappings of
          Left err -> TIO.putStrLn "Something is wrong while reading the file"
          Right defaultMap -> TIO.putStrLn $ mconcat ["Char ", myText, " corresponds to ", result]
                             where result = DefaultMap.lookup myText defaultMap

main :: IO ()
main = do
    putStrLn "Please enter a line."

