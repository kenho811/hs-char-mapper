{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE PackageImports #-}


module Main where

import "hs-char-mapper" Lib ( someFunc )

import qualified Data.Map as Map
import qualified Data.Vector
import qualified Data.Text


import qualified Data.ByteString.Lazy as BL
import Data.Csv ( decode, HasHeader(NoHeader) )
import qualified Data.Vector as V

-- codePointsMapper
-- Source:https://unicodelookup.com/
codePointsMapper:: Map.Map Int Int 
codePointsMapper = Map.fromList [
    (97,10),
    (2,20)
    ]

csvFile :: FilePath

csvFile = "mappings.copy.csv"

main :: IO ()
main = do
    let val = Map.lookup 2 codePointsMapper
    print val
    csvData <- BL.readFile "mappings.copy.csv"
    case decode NoHeader csvData of
            Left err -> putStrLn err
            Right v -> V.forM_ v $ \ (name, salary) ->
                putStrLn $ name ++ " earns " ++ salary ++ " dollars"
