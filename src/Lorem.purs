module Lorem (component) where

import Prelude
import Halogen as H
import Halogen.HTML as HH

type State = Course
type Name = String

type Course =
  { name :: String
  , teacher :: Name
  , semester :: String
  }

initialState :: forall i. i -> State
initialState _ = cga

cga :: Course
cga =
  { name: "Cohomology of Groups and Algebras"
  , teacher: "Dietrich Burde"
  , semester: "WS2022"
  }

lg :: Course
lg =
  { name: "Lie Groups"
  , teacher: "Andreas Cap"
  , semester: "WS2022"
  }

component :: forall q i o m. H.Component q i o m
component =
  H.mkComponent
    { initialState
    , render
    , eval: H.mkEval $ H.defaultEval
    }

showCourse :: Course -> String
showCourse course = course.name <> ", " <> course.teacher

render _ =
  HH.div_
    [ HH.text (showCourse cga)
    , HH.text (showCourse lg)
    ]
