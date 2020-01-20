module Model exposing (Model, Msg(..), init)

import Data.Artists exposing (Artist)
import Http exposing (Error(..))
import RemoteData exposing (WebData)


type alias Model =
    WebData (List Artist)


type Msg
    = GetSpotifyData
    | SpotifyResponse (WebData (List Artist))


init : ( Model, Cmd Msg )
init =
    ( RemoteData.NotAsked, Cmd.none )
