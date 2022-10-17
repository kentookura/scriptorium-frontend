module Uni.Calendar where

import Prelude
import Halogen as H
import Halogen.HTML as HH

import Data.JSDate as JSDate
import Data.DateTime

--foreign import square :: Number -> Number

--foreign import calendar :: String

component :: forall query input output m. H.Component query input output m
component =
  H.mkComponent
    { initialState
    , render
    , eval: H.mkEval H.defaultEval
    }
  where
  initialState = identity
  render state = HH.div [] [ HH.text "Calendar" ]
