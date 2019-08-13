{-
You can define your own types in Haskell. The notation is very different
from what you are used to if you're coming from a procedural background.    
-}

data YesNo = Yes | No

data Shape = Circle Float | Square Float | Rect Float Float

circumference :: Shape -> Float
circumference (Circle r) = 2 * r * pi
circumference (Square s) = 4 * s
circumference (Rect x y) = 2 * x + 2 * y

area :: Shape -> Float
area (Circle r) = pi * r**2 
area (Square s) = s**2
area (Rect x y) = x * y

{-
Types can be recursive:
-}

data BTree a = Empty | Node a (BTree a) (BTree a) deriving (Show)

insertBTree :: Ord a => BTree a -> a -> BTree a
insertBTree Empty e = Node e Empty Empty
insertBTree (Node n r l) e
    | e < n = Node n (insertBTree r e) l
    | otherwise = Node n r (insertBTree l e)

{-
Haskell has a record type notation which generates get functions for 
properties.
-}

data Record = Record {
    intField ::Int,
    stringField ::String
}

{-
You can also make an alias for an existing type. In this example we
create a type alias for a 2-tuple with float values.
-}

type Point = (Float, Float)

invert :: Point -> Point
invert (x,y) = (-x, -y)