module Main exposing (main, update, view)

import Browser
import Data.Artists exposing (Artist)
import Html exposing (Html, div, h1, header, text)
import Html.Attributes exposing (class)
import Http exposing (Error(..))
import RemoteData exposing (WebData)


type alias Model =
    WebData (List Artist)


type Msg
    = GetSpotifyData
    | SpotifyResponse (WebData (List Artist))


update : Msg -> Model -> ( Model, Cmd Msg )
update message _ =
    case message of
        GetSpotifyData ->
            ( RemoteData.Loading, getArtists )

        SpotifyResponse data ->
            ( data, Cmd.none )


view : Model -> Html Msg
view model =
    div [ class "container" ]
        [ header [] [ h1 [] [ text "My Favorite Recent Artists" ] ]
        , displayArtists model
        ]


displayArtists : WebData (List Artist) -> Html msg
displayArtists data =
    case data of
        RemoteData.NotAsked ->
            div [] [ text "Load the Data by clicking above!" ]

        RemoteData.Success artists ->
            div [ class "artists" ] (List.map displayArtist artists)

        RemoteData.Loading ->
            div [] [ text "Loading…" ]

        RemoteData.Failure _ ->
            div [] [ text "Whoopsies, pop those dev tools dawg [cmd+opt+i]" ]


displayArtist : Artist -> Html msg
displayArtist { genres, name } =
    div []
        [ div [ class "artist" ] [ text name ]
        , div [ class "genre" ] [ text (genres |> List.head |> Maybe.withDefault "") ]
        ]


main : Program () Model Msg
main =
    Browser.element
        { init = \_ -> init
        , update = update
        , view = view
        , subscriptions = \_ -> Sub.none
        }


init : ( Model, Cmd Msg )
init =
    update GetSpotifyData RemoteData.NotAsked


getArtists : Cmd Msg
getArtists =
    Http.get
        -- { url = "https://rodwrl4gq1.execute-api.us-east-1.amazonaws.com/Prod/hello/"
        { url = "https://deploy-preview-2--wizardly-wiles-29c9bb.netlify.app/.netlify/functions/spotify"
        , expect = Http.expectJson (RemoteData.fromResult >> SpotifyResponse) Data.Artists.decoder
        }
