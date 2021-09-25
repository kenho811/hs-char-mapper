-- {-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE PackageImports #-}
{-# LANGUAGE OverloadedStrings #-}

module Main where

import Lib ( someFunc )

import qualified Data.Map as Map
import qualified Data.Text as T
import qualified Data.String
import qualified Data.Vector as V
import qualified Data.ByteString.Lazy as BL

import Data.Csv ( encode,decode, HasHeader(NoHeader) )
import Data.List ()

-- codePointsMapper
-- Source:https://unicodelookup.com/
codePointsMapper:: Map.Map Int Int 
codePointsMapper = Map.fromList [
    (97,10),
    (2,20)
    ]

csvFile :: FilePath

csvFile = "mappings.copy.csv"

list:: [(T.Text, Int)]
list = [("John" :: T.Text, 27), ("Jane", 28)]

byteCode :: BL.ByteString
byteCode = encode Main.list

myEither :: Either String (V.Vector (T.Text, Int))
myEither = decode NoHeader "John,27\r\nJane,28\r\n" :: Either String (V.Vector (T.Text, Int))

main :: IO ()
main = do
    let val = Map.lookup 2 codePointsMapper
    print val
    csvData <- BL.readFile "mappings.copy.csv"
    case decode NoHeader csvData of
            Left err -> putStrLn err
            Right v -> V.forM_ v $ \ (name, salary) ->
                putStrLn $ name ++ " earns " ++ salary ++ " dollars"
    someFunc
    print byteCode
    print myEither

