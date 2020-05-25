main =  let arr = [1,2,3,4,5,6,7,8,9]
            search = 3
        in print (binsearch arr search 0 (length arr))

binsearch :: [Int] -> Int -> Int -> Int -> Int
binsearch xs value low high
   | high < low       = -1
   | xs!!mid > value  = binsearch xs value low (mid-1)
   | xs!!mid < value  = binsearch xs value (mid+1) high
   | otherwise        = mid
   where
   mid = low + ((high - low) `div` 2)