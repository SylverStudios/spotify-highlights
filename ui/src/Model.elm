module Model exposing (Model, Msg(..))

import Data.Artists exposing (Artist)
import Http exposing (Error(..))
import RemoteData exposing (WebData)


type alias Model =
    WebData (List Artist)


type Msg
    = GetSpotifyData
    | SpotifyResponse (WebData (List Artist))
