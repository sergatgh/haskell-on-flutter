-- COUNT LINES --

-- To use 'getArgs'
import System.Environment

-- To use 'doesFileExist':
import System.Directory

main = do
        -- Read CLI arguments into array (x:xs) where first value should be file name:
        (fileName:_) <- getArgs

        -- Check for file existence:
        fileExists <- doesFileExist fileName
        
        if fileExists
        
        -- Basic logic to read file, read lines, count lines and show the result:
        then do contents <- readFile fileName
                putStrLn $ "The file has " ++ show (length (lines contents)) ++ " lines!"
        
        else do putStrLn "The file doesn't exist!"