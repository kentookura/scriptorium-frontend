module Uni.Header where

import Prelude

import Uni.Utils (css, maybeElem, safeHref, whenElem)
import Uni.Avatar as Avatar
import Uni.Profile (ProfileRep)
import Uni.Route (Route(..))
import Uni.Username as Username
import Data.Maybe (Maybe, isJust, isNothing)
import Data.Monoid (guard)
import Halogen.HTML as HH
import Halogen.HTML.Properties as HP

-- | Our header will be a pure render function, but we'll require a route as an argument so we can
-- | judge whether a link should display active or not. We'll allow for any profile record type so
-- | long as it has our core fields -- this makes the header reusable across pages despite which
-- | variation on `Profile` they use.
header :: forall i p r. Maybe { | ProfileRep r } -> Route -> HH.HTML i p
header currentUser route =
  HH.nav
    [ css "navbar navbar-light" ]
    [ HH.div
        [ css "container" ]
        [ HH.a
            [ css "navbar-brand"
            , safeHref Home
            ]
            [ HH.text "conduit" ]
        , HH.ul
            [ css "nav navbar-nav pull-xs-right" ]
            [ navItem Home [ HH.text "Home" ] ]
        ]
    ]

  where

  navItem r html =
    HH.li
      [ css "nav-item" ]
      [ HH.a
          [ css $ "nav-link" <> guard (route == r) " active"
          , safeHref r
          ]
          html
      ]
