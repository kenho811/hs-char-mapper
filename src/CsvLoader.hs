module CsvLoader where

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

import DefaultMap ( DefaultMap(DefaultMap), fromMap )

import Data.Csv ( encode,decode, HasHeader(NoHeader) )

type FileName = String
type FromSymbol = T.Text 
type ToSymbol = T.Text


-- | Get the mappings from a CSV file and turn it into a DefaultMap for lookup
initMappings :: ToSymbol -> FileName -> IO(Either String (DefaultMap.DefaultMap FromSymbol ToSymbol))
initMappings defaultSymbol fileName = withUtf8 $ do
  -- read content of file as ByteString
  csvData <- BL.readFile fileName
  -- transform the right vector to right Map
  case decode NoHeader csvData of
      Left err -> return $ Left err
      Right v -> return $ Right $ DefaultMap.fromMap defaultSymbol $ vectorTupleToMap v

-- | Print the mappings from the CSV file
previewMappings :: FileName -> IO()
previewMappings fileName = withUtf8 $ do
    let dummyDefaultSymbol = " "
    eitherMap <- initMappings dummyDefaultSymbol fileName
    case eitherMap of
      Left err -> putStrLn err
      Right (DefaultMap.DefaultMap defVal map) -> mapM_ (\(key, val) -> TIO.putStrLn $ mconcat [key, " --> ", val]) $ Map.toList map

-- | Utility function to turn Vector into a Map
vectorTupleToMap:: (Ord a) => V.Vector (a, b) -> Map.Map a b 
vectorTupleToMap = Map.fromList . V.toList
