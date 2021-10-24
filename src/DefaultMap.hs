module DefaultMap (
    DefaultMap
    , fromMap
    , toMap
    , DefaultMap.lookup
    , sampleMap
)

where 

import qualified Data.Map as Map 
import Data.Maybe ( fromMaybe )
import GHC.Show (Show)

-- | DefaultMap holds two attributes (i) A default value and (ii) a normal Map
data DefaultMap k v = DefaultMap {
    defVal :: v
    , map :: Map.Map k v
} deriving (Show)

-- | Create a DefaultMap from a normal Map
fromMap :: v -> Map.Map k v -> DefaultMap k v
fromMap v map = DefaultMap {
    defVal = v
    , map = map
}

-- | Convert a DefaultMap to a normal Map
toMap:: DefaultMap k v -> Map.Map k v
toMap DefaultMap {defVal = defVal, map = map } = map


-- | Lookup in DefaultMap. Return default when value not found in the normal Map
lookup :: (Ord k, Num v) => k -> DefaultMap k v -> v
lookup k DefaultMap {defVal = defVal, map = map} = Data.Maybe.fromMaybe defVal (Map.lookup k map)

sampleMap :: (Ord a, Num a, Num b) => Map.Map a b
sampleMap = Map.fromList [(1, 10), (2,20), (3, 30)]

