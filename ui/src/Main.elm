module Main exposing (main, update, view)

import Browser
import Data.Artists exposing (Artist)
import Html exposing (Html, div, header, text, h1)
import Html.Attributes exposing (class)
import Http exposing (Error(..))
import Model exposing (Model, Msg(..))
import RemoteData exposing (WebData)


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
        { url = "https://rodwrl4gq1.execute-api.us-east-1.amazonaws.com/Prod/hello/"
        , expect = Http.expectJson (RemoteData.fromResult >> SpotifyResponse) Data.Artists.decoder
        }