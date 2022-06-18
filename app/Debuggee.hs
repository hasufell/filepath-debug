{-# LANGUAGE TypeApplications #-}

module Main where

import System.AbstractFilePath.Types

import qualified Data.ByteString.Lazy as BSL
import qualified Data.ByteString as BS
import Control.DeepSeq ( force )
import Control.Exception ( evaluate )

import GHC.Debug.Stub
import Text.Read
import System.Environment


data FP = FP1 [FilePath]
        | FP2 [BS.ByteString]
        | FP3 [BSL.ByteString]
        | FP4 [AbstractFilePath]
  deriving Show

main :: IO ()
main = withGhcDebug $ do
  args <- getArgs
  paths <- case args of
    [] -> do
      f <- readFile "data/posix_files"
      let (Just paths) = readMaybe @[FilePath] f
      evaluate $ force paths
      print (length paths)
      pause
      pure $ FP1 paths
    ("bs":_) -> do
      f <- readFile "data/posix_files"
      let (Just paths) = readMaybe @[BS.ByteString] f
      evaluate $ force paths
      print (length paths)
      pause
      pure $ FP2 paths
    ("bsl":_) -> do
      f <- readFile "data/posix_files"
      let (Just paths) = readMaybe @[BSL.ByteString] f
      evaluate $ force paths
      print (length paths)
      pause
      pure $ FP3 paths
    ("afpp":_) -> do
      f <- readFile "data/posix_files"
      let (Just paths) = readMaybe @[AbstractFilePath] f
      evaluate $ force paths
      print (length paths)
      pause
      pure $ FP4 paths
  print paths
  pure ()
