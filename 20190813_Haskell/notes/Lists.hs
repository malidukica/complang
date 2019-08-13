{-
We can define a list with numbers:
-}

xs = [1,2,3]

{-
Remember how in Haskell there are no side effects? Lists in Haskell are immutable,
meaning that you cannot add an element to an existing list. Lists are actually 
constructed by appending elements to the empty list using the cons operator ':',
but each append operation creates a new list instance. We will see later why this 
is useful.
-}
xs' = 1:2:3:[]

xs'' = [1..3]

{-
We can also generate lists of numbers with a pattern:
-}

fives = [0,5..100]

{-
One cool feature of Haskell is that it is lazily evaluated. We can define
the "infinite" list of natural numbers like this. It will be evaluated when 
needded. Be careful though - writing just [1..] in ghci will cause it to be
evaluated, meaning ghci will print numbers untill you ctrl-c
-}
naturalNumbers = [1..]

{-
we can continue defining a list containing all even numbers:
-}

evenNumbers = filter even naturalNumbers

--or using list comprehension

evenNumbers' = [x | x <- naturalNumbers, even x]