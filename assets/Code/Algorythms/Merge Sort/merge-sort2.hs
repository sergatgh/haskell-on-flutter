-- MERGE SORT 2 (minified) --

main = print $ sort [5,4,3,2,1]

sort :: (Ord a) => [a] -> [a]
sort = mergeAll . map (:[]) 
  where
    mergeAll [] = []
    mergeAll [t] = t
    mergeAll xs  = mergeAll (mergePairs xs)

    mergePairs (x:y:xs) = merge x y:mergePairs xs
    mergePairs xs = xs

    merge xs [] = xs
    merge [] ys = ys
    merge (x:xs) (y:ys) 
      | x < y = (x : merge xs (y:ys))
      | otherwise = (y : merge (x:xs) ys)