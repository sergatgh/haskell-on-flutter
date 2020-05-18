import 'package:flutter/material.dart';

import 'content.dart';
import 'content_link.dart';
import 'content_manager.dart';

class TestContent {
  static ContentManager getTestContent() {
    return ContentManager(<ContentPageData>[
      ContentPageData(
          icon: Icon(Icons.flag),
          contents: <ContentData>[
            ContentData(content: """```
main = putStrLn "Hello, world!"
```""", icon: Icon(Icons.code))
          ],
          title: "Hello World!"),
      ContentPageData(
          icon: Icon(Icons.sort),
          contents: <ContentData>[
            ContentData(content: """```
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
```"""),
            ContentData(content: """
```sort :: (Ord a) => [a] -> [a]
sort = mergeAll . map (:[]) 
  where
    mergeAll [] = []
    mergeAll [t] = t
    mergeAll xs  = mergeAll (mergePairs xs)

    mergePairs (x:y:xs) = merge x y:mergePairs xs
    mergePairs xs = xs
```""")
          ],
          title: "Merge Sort"),
      ContentPageData(
          icon: Icon(Icons.search),
          contents: <ContentData>[
            ContentData(content: """```
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
```""")
          ],
          title: "Binary Search"),
          ContentPageData(
            icon: Icon(Icons.format_list_numbered_rtl),
            title: "Read file - count lines",
            contents: [
              ContentData(content: """```import System.Environment  
import System.IO  
import System.Directory  
  
main = do (fileName:_) <- getArgs  
          fileExists <- doesFileExist fileName  
          if fileExists  
              then do contents <- readFile fileName  
                      putStrLn \$ "The file has " ++ show (length (lines contents)) ++ " lines!"  
              else do putStrLn "The file doesn't exist!"```""",)
            ]
          )
    ]);
  }
}
