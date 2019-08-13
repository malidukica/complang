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

{-
implement the function below to find the optimal time to buy and sell the 
msft stock this year. It might be wise to add some additional helper functions

bonus I: read the high and low fields from the file as well
bonus II: add a function calculating the 10-day moving average of the high and low price.
bonus III: Create a strategy that buys when the stock price is below the low MA and sells 
            when the profit is >= 10% or <= -5%. Test this on the msft.csv file or download
            another file from historical data on yahoo finance
-}
bestTrade :: [Quote] -> Trade