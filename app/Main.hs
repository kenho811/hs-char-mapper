{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ScopedTypeVariables #-}

module Main where

import Control.Exception (IOException)
import qualified Control.Exception as Exception
import qualified Data.Foldable as Foldable

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
import Data.List ()
import Lib ( getMappedSymbol, getMappings )

type FromSymbols = T.Text
type ToSymbols = T.Text
type DefaultSymbol = T.Text


-- getMappedSymbols :: FromSymbols -> DefaultSymbol -> ToSymbols
-- getMappedSymbols fromSymbols defaultSymbol = withUtf8 $ do
--     mappings <- getMappings "mappings.csv"
--     T.map (\char -> getMappedSymbolWithDefault defaultSymbol (T.pack [char]) mappings) fromSymbols


-- getMappedSymbolWithDefault :: DefaultSymbol -> FromSymbol -> Either String (Map.Map FromSymbol ToSymbol) -> ToSymbol
-- getMappedSymbolWithDefault defaultSymbol fromSymbol mappings = withUtf8 $ do
--   -- let mayBeSymbolTo = getMappedSymbol fromSymbol mappings
--   var <- return $ T.pack "a"
--   -- case mayBeSymbolTo of
--   --   Nothing -> defaultSymbol
--   --   Just x -> x

getMappedSymbolMsg :: IO()
getMappedSymbolMsg = withUtf8 $ do
    myText <- fmap T.pack getLine
    mappings <- getMappings "mappings.csv"
    let maybeSymbolTo = getMappedSymbol myText mappings
    case maybeSymbolTo of
          Nothing -> TIO.putStrLn $ mconcat ["Char ", myText, " does not correspond to any symbol!"]
          Just x -> TIO.putStrLn $ mconcat ["Char ", myText, " corresponds to ", x]

main :: IO ()
main = do
  let myEither = Right "abcd" :: Either a String
  case myEither of
    Left err -> putStrLn "Nothing"
    Right x -> putStrLn x
