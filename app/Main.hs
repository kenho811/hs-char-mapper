{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ScopedTypeVariables #-}

module Main where

import qualified CLI.Cli as Cli
import qualified GUI.Gui as Gui


main :: IO ()
-- main = Cli.runCli
main = Gui.runGui