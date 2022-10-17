module Uni.Course where

import Prelude
import Uni.Calendar
import Uni.Utils
import Halogen as H
import Halogen.HTML as HH
import Type.Proxy (Proxy(..))

type OpaqueSlot slot = forall query. H.Slot query Void slot
type Slots = (course :: forall query. H.Slot query Void Int)
_course = Proxy :: Proxy "course"

type ChildSlots = (rawHtml :: OpaqueSlot Unit)
type Name = String
type Title = String
type Teacher = String
type ECTS = Int
data Action = Update
data Language = English | German

type Course =
  { name :: String
  , teacher :: Name
  , semester :: String
  , ects :: ECTS
  , language :: Language
  }

cga :: Course
cga =
  { name: "Cohomology of Groups and Algebras"
  , teacher: "Dietrich Burde"
  , semester: "WS2022"
  , ects: 5
  , language: English
  }

lg :: Course
lg =
  { name: "Lie Groups"
  , teacher: "Andreas Cap"
  , semester: "WS2022"
  , ects: 5
  , language: English
  }

type Input = Course
type State = { courses :: Array Course }

courseList :: forall query input output m. H.Component query input output m
courseList =
  H.mkComponent
    { initialState
    , render
    , eval: H.mkEval H.defaultEval
    }
  where
  initialState _ = { courses: [ lg, cga ] }

--render :: forall state action. state -> H.ComponentHTML action Slots m
--render :: State -> H.ComponentHTML Action ChildSlots m
render state = HH.div [] (viewCourse <$> state.courses)

viewCourse course =
  HH.div
    [ css "card" ]
    [ HH.div
        [ css "card-block" ]
        [ HH.h3_
            [ HH.text course.name
            ]
        ]
    , HH.div []
        [ HH.text course.teacher
        ]
    ]

courseComponent :: forall query output m. H.Component query Input output m
courseComponent = H.mkComponent
  { initialState
  , render
  , eval: H.mkEval H.defaultEval
  }
  where
  initialState :: Input -> Course
  initialState input = input

  render :: forall action. Course -> H.ComponentHTML action () m
  render course = HH.div [] [ HH.text (course.name) ]

--courseList :: forall q i o m. H.Component q i o m
--courseList =
--  H.mkComponent
--    { allCourses
--    , renderCourseList
--    , eval: H.mkEval $ H.defaultEval { handleAction = handleAction }
--    }
--  where

renderCourseList :: forall m. Array Course -> H.ComponentHTML Action () m
renderCourseList courses =
  HH.div_ (map renderCourse courses)

--courseComponent :: Course -> forall q i o m. H.Component q i o m
--courseComponent course =
--  H.mkComponent
--    { initialState
--    , renderCourse
--    , eval: H.mkEval $ H.defaultEval { handleAction = handleAction }
--    }
--  where
--  initialState _ = lg

renderCourse :: forall m. Course -> H.ComponentHTML Action () m
renderCourse course =
  HH.div_ [ renderTitle course.name, renderTeacher course.teacher, HH.text ("ECTS: " <> show course.ects) ]

--handleAction :: forall output m. Action -> H.HalogenM Course Action () output m Unit
handleAction = case _ of
  Update -> H.modify_ \state -> state

renderTitle :: forall w i. Title -> HH.HTML w i
renderTitle title = HH.h1_ [ HH.text title ]

renderTeacher :: forall w i. Teacher -> HH.HTML w i
renderTeacher teacher = HH.text teacher
