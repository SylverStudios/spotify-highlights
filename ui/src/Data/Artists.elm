module Data.Artists exposing (Artist, decoder)

import Json.Decode as Decode
import Json.Decode.Pipeline as Pipeline


type alias Artist =
    { genres : List String
    , name : String
    }


decoder : Decode.Decoder (List Artist)
decoder =
    Decode.list artistDecoder


artistDecoder : Decode.Decoder Artist
artistDecoder =
    Decode.succeed Artist
        |> Pipeline.required "genres" (Decode.list Decode.string)
        |> Pipeline.required "name" Decode.string
