#!/usr/bin/env stack

{-# LANGUAGE OverloadedStrings #-}
import		 Data.Aeson	       (Value)
import qualified Data.ByteString.Char8 as S8
import           Data.Char             (toUpper)
import qualified Data.Yaml	       as Yaml
import 		 Network.HTTP.Simple

main :: IO ()
main = do

    -- api/supply/ada API query
    putStrLn $ "#########################################################\n" 

    oldRequest <- parseRequest "http://cardanoexplorer.com/api/supply/ada"
    oldResponse <- httpJSON oldRequest    
    let oldResponseBody = Yaml.encode (getResponseBody oldResponse :: Value)

    newRequest <- parseRequest "http://localhost:8100/api/supply/ada"
    newResponse <- httpJSON newRequest
    let newResponseBody = Yaml.encode (getResponseBody newResponse :: Value)

    putStrLn $ "api/supply/ada equality: " ++ showBool (oldResponseBody == newResponseBody) ++ "\n"
    
    putStrLn $ "Old Explorer Response: "
    S8.putStrLn $ oldResponseBody
    putStrLn $ "New Explorer Response: "
    S8.putStrLn $ newResponseBody 

    putStrLn $ "########################################################\n"

    -- /api/blocks/pages/total
    oldRequest <- parseRequest "http://cardanoexplorer.com/api/blocks/pages/total"
    oldResponse <- httpJSON oldRequest
    let oldResponseBody = Yaml.encode (getResponseBody oldResponse :: Value)

    newRequest <- parseRequest "http://localhost:8100/api/blocks/pages/total"
    newResponse <- httpJSON newRequest
    let newResponseBody = Yaml.encode (getResponseBody newResponse :: Value)
    
    putStrLn $ "api/blocks/pages/total equality: " ++ showBool (oldResponseBody == newResponseBody) ++ "\n"
    
    putStrLn $ "Old Explorer Response: "
    S8.putStrLn $ oldResponseBody
    putStrLn $ "New Explorer Response: "
    S8.putStrLn $ newResponseBody
 
    putStrLn $ "#######################################################\n"

    -- api/blocks/txs/<hash>
    oldRequest <- parseRequest "http://cardanoexplorer.com/api/blocks/txs/fb219a1b0d7b331a5dcc41861254a5f841b50a6cb52fe558bdefa27141a07b91"
    oldResponse <- httpJSON oldRequest
    let oldResponseBody = Yaml.encode (getResponseBody oldResponse :: Value)

    newRequest <- parseRequest "http://localhost:8100/api/blocks/txs/fb219a1b0d7b331a5dcc41861254a5f841b50a6cb52fe558bdefa27141a07b91"
    newResponse <- httpJSON newRequest
    let newResponseBody = Yaml.encode (getResponseBody newResponse :: Value)

    putStrLn $ "api/blocks/txs/fb219a1b0d7b331a5dcc41861254a5f841b50a6cb52fe558bdefa27141a07b91 equality: " ++ showBool (oldResponseBody == newResponseBody) ++ "\n"
    
    putStrLn $ "Old Explorer Response: "
    S8.putStrLn $ oldResponseBody
    putStrLn $ "New Explorer Response: "
    S8.putStrLn $ newResponseBody

    putStrLn $ "######################################################\n"

    -- api/txs/summary/<hash>
 
    oldRequest <- parseRequest "http://cardanoexplorer.com/api/txs/summary/fb219a1b0d7b331a5dcc41861254a5f841b50a6cb52fe558bdefa27141a07b91"
    oldResponse <- httpJSON oldRequest
    let oldResponseBody = Yaml.encode (getResponseBody oldResponse :: Value)

    newRequest <- parseRequest "http://localhost:8100/api/txs/summary/fb219a1b0d7b331a5dcc41861254a5f841b50a6cb52fe558bdefa27141a07b91"
    newResponse <- httpJSON newRequest
    let newResponseBody = Yaml.encode (getResponseBody newResponse :: Value)

    putStrLn $ "api/txs/summary/fb219a1b0d7b331a5dcc41861254a5f841b50a6cb52fe558bdefa27141a07b91 equality: " ++ showBool (oldResponseBody == newResponseBody) ++ "\n"
    
    putStrLn $ "Old Explorer Response: "
    S8.putStrLn $ oldResponseBody
    putStrLn $ "New Explorer Response: "
    S8.putStrLn $ newResponseBody

    putStrLn $ "######################################################\n"



showBool :: Bool -> String
showBool = map toUpper . show
