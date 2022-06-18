{-# LANGUAGE TypeApplications #-}

module Main where

import GHC.Debug.Client
import GHC.Debug.Fragmentation
import System.Environment

main :: IO ()
main = do
  args <- getArgs
  case args of
    [] -> withDebuggeeConnect "/tmp/ghc-debug" p1
    (fp:_) -> withDebuggeeConnect fp p1

p1 :: Debuggee -> IO ()
p1 e = do
  pause e
  bs <- run e precacheBlocks
  summariseBlocks bs
  resume e
