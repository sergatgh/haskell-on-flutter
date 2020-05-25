main = (print . mergesort) ["3"]

mergesort :: [String] -> [String]
mergesort = mergesort' . map wrap

mergesort' :: [[String]] -> [String]
mergesort' [] = []
mergesort' [xs] = xs
mergesort' xss = mergesort' (merge_pairs xss)

merge_pairs :: [[String]] -> [[String]]
merge_pairs [] = []
merge_pairs [xs] = [xs]
merge_pairs (xs:ys:xss) = merge xs ys : merge_pairs xss

merge :: [String] -> [String] -> [String]
merge [] ys = ys
merge xs [] = xs
merge (x:xs) (y:ys)
 =
    if x > y
        then (y : merge (x:xs)  ys)
        else (x : merge  xs    (y:ys))

wrap :: String -> [String]
wrap x = [x]