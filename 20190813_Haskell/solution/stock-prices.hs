import Data.List
import Data.List.Split
import Data.Time.Calendar
import Data.Time.Format

data Quote = Quote {
    timestamp :: Day,
    close :: Double
} deriving (Eq, Show)

data Trade = Trade {
    buy :: Quote,
    sell :: Quote,
    profit :: Double
} deriving (Eq, Show)

(Quote _ c1) `compareClose` (Quote _ c2) = c1 `compare` c2
(Quote ts1 _) `compareTime` (Quote ts2 _) = ts1 `compare` ts2

instance Ord Trade where
    (Trade _ _ p1) `compare` (Trade _ _ p2) = p1 `compare` p2

minBy :: (a -> a -> Ordering) -> a -> a -> a
minBy cmp a b = case cmp a b of 
                    GT -> b
                    _ -> a

main = do 
    text <- readFile "./MSFT.csv"
    let ls = lines text
    let quotes = parseFile (drop 1 ls)
    print (bestTrade $ sortBy compareTime quotes)
     
parseFile :: [String] -> [Quote]
parseFile = map readQuote

readQuote :: String -> Quote
readQuote str = Quote (parseTimeOrError True defaultTimeLocale "%Y-%m-%d" ts ::Day) (read adj_close ::Double)
    where (ts:open:hi:lo:close:adj_close:vol) = splitOn "," str
        
bestTrade :: [Quote] -> Trade
bestTrade prices = maximum (trades prices) 

trades :: [Quote] -> [Trade]
trades prices = zipWith trade lows prices
    where lows = scanl1 (minBy compareClose) prices

trade :: Quote -> Quote -> Trade
trade buy sell = Trade buy sell (price - cost)
    where price = close sell
          cost = close buy

performance :: Double -> Double -> Double
performance close prev = close / prev - 1

performanceSeries :: [Double] -> [Double]
performanceSeries ps = zipWith performance closes previous
                        where closes = tail ps
                              previous = init ps