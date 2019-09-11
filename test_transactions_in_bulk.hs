#!/usr/bin/env stack

{-# LANGUAGE OverloadedStrings #-}
import		 Data.Aeson	       (Value)
import qualified Data.ByteString.Char8 as S8
import           Data.Char             (toUpper)
import qualified Data.Yaml	       as Yaml
import 		 Network.HTTP.Simple

main :: IO ()
main = do
    f <- readFile "hash_list.txt"
    mapM_ checkEquality $ lines f
    

showBool :: Bool -> String
showBool = map toUpper . show

checkEquality :: String -> IO ()
checkEquality x = do
    -- Test URLS    
    -- putStrLn $ "http://cardanoexplorer.com/api/txs/summary/" ++ x
    -- putStrLn $ "http://localhost:8100/api/txs/summary/" ++ x

    oldRequest <- parseRequest $ "http://cardanoexplorer.com/api/txs/summary/" ++ x
    oldResponse <- httpJSON oldRequest
    let oldResponseBody = Yaml.encode (getResponseBody oldResponse :: Value)

    newRequest <- parseRequest $ "http://localhost:8100/api/txs/summary/" ++ x
    newResponse <- httpJSON newRequest
    let newResponseBody = Yaml.encode (getResponseBody newResponse :: Value)

    putStrLn $ "api/txs/summary/" ++ x ++ " equality: " ++ showBool (oldResponseBody == newResponseBody)

    oldRequest <- parseRequest $ "http://cardanoexplorer.com/api/blocks/txs/" ++ x
    oldResponse <- httpJSON oldRequest
    let oldResponseBody = Yaml.encode (getResponseBody oldResponse :: Value)

    newRequest <- parseRequest $ "http://localhost:8100/api/blocks/txs/" ++ x
    newResponse <- httpJSON newRequest
    let newResponseBody = Yaml.encode (getResponseBody newResponse :: Value)

    putStrLn $ "api/blocks/txs/" ++ x ++ " equality: " ++ showBool (oldResponseBody == newResponseBody) ++ "\n"

