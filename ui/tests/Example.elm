module Example exposing (unitTest)

import Expect
import Main exposing (update)
import Model exposing (Msg(..))
import RemoteData
import Test exposing (Test, describe, test)
import Test.Html.Selector exposing (tag, text)


{-| See <https://github.com/elm-community/elm-test>
-}
unitTest : Test
unitTest =
    describe "simple unit test"
        [ test "Inc adds one" <|
            \() ->
                update (SpotifyResponse RemoteData.Loading) RemoteData.NotAsked
                    |> Tuple.first
                    |> Expect.equal RemoteData.Loading
        ]



-- {-| see <https://github.com/eeue56/elm-html-test>
-- -}
-- viewTest : Test
-- viewTest =
--     describe "Testing view function"
--         [ test "Button has the expected text" <|
--             \() ->
--                 Model 0 ""
--                     |> view
--                     |> Query.fromHtml
--                     |> Query.findAll [ tag "button" ]
--                     |> Query.first
--                     |> Query.has [ text "+ 1" ]
--         ]
