{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ScopedTypeVariables #-}

module Main where

import qualified CLI.Cli as Cli


main :: IO ()
main = Cli.runCli