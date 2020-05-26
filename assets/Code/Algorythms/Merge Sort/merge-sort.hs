-- MERGE SORT --

main = let array = [ "D", "C", "B", "A" ]
           result = sort array
           
        in print result

{-
    Break down an array into
    one elements arrays with
    map wrap function.
    [ "D", "C", "B", "A" ] =>
    [ ["D"], ["C"], ["B"], ["A"] ]

    later will be merged by
    mergesort' function like this
    [ ["D"], ["C"], ["B"], ["A"] ] =>
    [ ["C", "D"], ["A", "B"] ] =>
    [ ["A, "B", "C", "D"] ] =>
    ["A, "B", "C", "D"]
-}
sort :: [String] -> [String]
sort = mergesort' . map wrap


-- Merges arrays up until there is only one to be returned.
mergesort' :: [[String]] -> [String]
mergesort' [] = []

-- Single array means that all sub-arrays have been sorted:
mergesort' [single] = single

-- Sort sub-arrays if two or more and repeat until there is only one:
mergesort' xss = mergesort' (merge_pairs xss)


{- 
    Iterating through array pairs, 
    making one array from each two arrays.
    ["A", "D"] ["B", "C"] ["E"] =>
    ["A", "B", "C", "D"] ["E"]
-}
merge_pairs :: [[String]] -> [[String]]
merge_pairs [] = []
merge_pairs [xs] = [xs]
merge_pairs (xs:ys:xss) = merge xs ys : merge_pairs xss


{- 
    Merges two sorted arrays into one sorted.
    ["B"] ["A"] => ["A", "B"]
-}
merge :: [String] -> [String] -> [String]

-- Check empty arrays:
merge [] ys = ys
merge xs [] = xs

-- Merge by comparing first elements of arrays:
merge (x:xs) (y:ys)
 =
    if x < y
        then (x : merge  xs    (y:ys))
        else (y : merge (x:xs)  ys)


-- Wrap single string into array.
wrap :: String -> [String]
wrap x = [x]