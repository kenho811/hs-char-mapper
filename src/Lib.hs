module Lib where

import Main.Utf8

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

type FileName = String
type FromSymbol = T.Text
type ToSymbol = T.Text

-- | Get the mappings from a CSV file and turn it into a Map for lookup
getMappings :: FileName -> IO(Either String (Map.Map FromSymbol ToSymbol))
getMappings fileName = withUtf8 $ do
  -- read content of file as ByteString
  csvData <- BL.readFile fileName
  -- transform the right vector to right Map
  case decode NoHeader csvData of
      Left err -> return $ Left err
      Right v -> return $ Right $ vectorTupleToMap v

-- | Print the mappings from the CSV file
previewMappings :: FileName -> IO()
previewMappings fileName = withUtf8 $ do
    eitherMap <- getMappings fileName
    case eitherMap of
      Left err -> putStrLn err
      Right map -> mapM_ (\(key, val) -> TIO.putStrLn $ mconcat [key, " --> ", val]) $ Map.toList map

-- | Utility function to turn Vector into a Map
vectorTupleToMap:: (Ord a) => V.Vector (a, b) -> Map.Map a b 
vectorTupleToMap = Map.fromList . V.toList

getMappedSymbol :: FromSymbol -> Either String (Map.Map FromSymbol ToSymbol) -> Maybe ToSymbol
getMappedSymbol symbolFrom eitherMappings = do
    case eitherMappings of
        Left err -> Nothing
        Right mappings -> Map.lookup symbolFrom mappings