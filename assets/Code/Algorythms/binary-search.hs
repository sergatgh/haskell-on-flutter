-- BINARY SEARCH --

-- Find member 3 in array
main = let array = [1,2,3,4,5,6,7,8,9]
           member = 3
           from = 0
           to = (length array)

           index = search member array from to

        -- Output result '2'
        in print (index)


-- Accepts 'value' and 'array' and a range of search in array.
search :: Int -> [Int] -> Int -> Int -> Int
search value array low high
   
   -- Search can not be executed:
   | high < low          = -1
   | high < 0            = -1
   | length array < low  = -1

   -- Check the middle value (mid will be calculated later):
   | array!!mid > value  = search value array low (mid-1)
   | array!!mid < value  = search value array (mid+1) high
   | otherwise           = mid
   
   -- Calculate middle value:
   where
   mid = low + ((high - low) `div` 2)