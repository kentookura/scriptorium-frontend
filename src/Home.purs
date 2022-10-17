module Uni.Home where

import Prelude
import Uni.Course as Course
import Uni.Calendar as Calendar
import Halogen as H
import Halogen.HTML as HH
import Halogen.HTML.Properties as HP
import Uni.Utils (css)
import Type.Proxy (Proxy(..))

type Slots =
  ( courseList :: forall query. H.Slot query Void Int
  , calendar :: forall query. H.Slot query Void Unit
  )

_courseList = Proxy :: Proxy "courseList"
_calendar = Proxy :: Proxy "calendar"

component :: forall query input output m. H.Component query input output m
component =
  H.mkComponent
    { initialState: identity
    , render
    , eval: H.mkEval H.defaultEval
    }
  where
  render :: forall state action. state -> H.ComponentHTML action Slots m
  render _ =
    HH.main
      [ HP.classes [ HH.ClassName "container" ] ]
      [ navbar
      , HH.slot_ _courseList 0 Course.courseList {}
      , HH.slot_ _calendar unit Calendar.component {}
      ]
    where
    navbar =
      HH.header
        [ css "header" ]
        [ HH.div
            [ css "container" ]
            [ HH.h1
                [ css "logo-font" ]
                [ HH.text "Scriptorium" ]
            , HH.p_
                [ HH.text "University of Vienna" ]
            ]
        ]
