module Main exposing (main, update, view)

import Browser
import Data.Artists exposing (Artist)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Http exposing (Error(..))
import Model exposing (Model, Msg(..), init)
import RemoteData exposing (WebData)



-- ---------------------------
-- UPDATE
-- ---------------------------


update : Msg -> Model -> ( Model, Cmd Msg )
update message model =
    case message of
        GetSpotifyData ->
            ( model
            , Http.get
                { url = "https://rodwrl4gq1.execute-api.us-east-1.amazonaws.com/Prod/hello/"
                , expect = Http.expectJson (RemoteData.fromResult >> SpotifyResponse) Data.Artists.decoder
                }
            )

        SpotifyResponse data ->
            ( data, Cmd.none )



-- ---------------------------
-- VIEW
-- ---------------------------


view : Model -> Html Msg
view model =
    div [ class "container" ]
        [ header [] [ h1 [] [ text "My Favorite Recent Artists" ] ]
        , div [ class "pure-g" ]
            [ div [ class "pure-u-1-3" ]
                [ button
                    [ class "pure-button pure-button-primary", onClick GetSpotifyData ]
                    [ text "Request it." ]
                ]
            , div [ class "pure-u-1-3" ] []
            , div [ class "pure-u-1-3" ] [ displayArtists model ]
            ]
        ]


displayArtists : WebData (List Artist) -> Html msg
displayArtists data =
    case data of
        RemoteData.NotAsked ->
            div [] [ text "Load the Data by clicking above!" ]

        RemoteData.Success artists ->
            div [] (List.map displayArtist artists)

        RemoteData.Loading ->
            div [] [ text "Loading…" ]

        RemoteData.Failure _ ->
            div [] [ text "Whoopsies, pop those dev tools dawg [cmd+opt+i]" ]


displayArtist : Artist -> Html msg
displayArtist { genres, name } =
    div []
        [ h1 [] [ text name ]
        , span [] [ text "Genres: " ]
        , span []
            [ text <| String.join ", " genres
            ]
        ]



-- ---------------------------
-- MAIN
-- ---------------------------


main : Program () Model Msg
main =
    Browser.document
        { init = \_ -> init
        , update = update
        , view =
            \m ->
                { title = "Elm 0.19 starter"
                , body = [ view m ]
                }
        , subscriptions = \_ -> Sub.none
        }
