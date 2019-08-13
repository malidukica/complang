{- 
    Functions in Haskell only have one parameter. 

    In addOnes type signature, Num a means that a is any Numeric type, 
    we will use a in the rest of the type signature. a -> a just means that
    it is a function from value of the type a to a value of the type a
-}
addOne :: Num a => a -> a
addOne x = x + 1

{-
    But having only one parameter seems kind of useless. Luckily Haskell is 
    intended to be very compositional, so the way to use more parameters is 
    to create a function with one parameter that returns another function 
    which takes another parameter.
-}
add :: Num a => a -> (a -> a)
add x y = x + y

{-
    Another way to have two parameters for a Haskell function is to use 
    tuples as the parameter. This has the disadvantage that it canot be
    partially applied.
-}
add' :: Num a => (a,a) -> abs
add' (x,y) = x + y

{-
    As a sidenote, we can use two built-in functions called curry and uncurry.

    Calling curry with a function of the type "Num a => (a,a) -> a" as 
    the parameter, will return a function of the type "Num a => a -> a -> a".
    Uncurry is, as the name implies, the inverse.
-}

{-
    Haskell is very algebraic in its syntax. We do not need to explicitly say
    that we will have a parameter when it can be inferred. 

    Wrapping ** in braces means we will use the operator as a function.
    (**) has the type Floating a => a -> a -> a

    But in our square function, we have already given it an argument, 2. So
    the type of square is Floating a => a -> a

    This is called partial application
-}
square::Floating a => a->a
square = (**2)

{-  
    Haskell also has a function composition operator; f . g is equivalent to
    f(g(x)) Which means we can define abs, a function for the absolute value 
    of a number, as follows:
-}
abs = sqrt . square

{-
    Even though Haskell has if/else statements, it is seldom used. The
    reason why is that Haskell has some much more powerful concepts.

    Functions can have guard clauses or even have different definitions 
    based on pattern matching.
-}

fizzbuzz n 
    | n `mod` 15 == 0 = "fizzbuzz"
    | n `mod` 3 == 0 = "fizz"
    | n `mod` 5 == 0 = "buzz"
    | otherwise = show n

safeDiv _ 0 = Nothing
safeDiv x y = Just (x `div` y)

imageType (0x89:0x50:0x4E:0x47:0x0D:0x0A:0x1A:0x0A:_) = "PNG"
imageType (0x47:0x49:0x46:0x38:0x37:0x61:_) = "GIF"
imageType (0x47:0x49:0x46:0x38:0x39:0x61:_) = "GIF"
imageType (0x49:0x49:0x2A:0x00:_) = "TIFF"
imageType (0xFF:0xD8:0xFF:0xDB:_) = "JPG"
imageType _ = "Unknown"