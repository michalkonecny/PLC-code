{-
  To execute this program, paste the content of this file
  to http://elm-lang.org/try and press "compile".
-}
import Html exposing (..)
import Html.Attributes as A exposing (..)
import Html.Events exposing (onInput)
import String
import List


main =
  beginnerProgram { model = initModel, view = view, update = update }

initModel : Int
initModel = 15

update : Int -> Int -> Int
update msg model = msg

view model =
  div []
    [
      slider { makeMsg = identity, minValue = 1, maxValue = 20, model = model }
    , text ("size = " ++ toString model)
    , tableFromLines (circleLines model) model
    ]

circleLines : Int -> List (List String)
circleLines size =
  let
    circleLine i = List.map (circleCell i) (List.range 1 (2*size))
    circleCell i jj =
      let j = jj // 2 in
        if shouldShow size i j then "*" else " "
  in
    List.map circleLine (List.range  1 size)

shouldShow size i j = shouldShowS size i j

shouldShowS s i j = abs (i^2 + j^2 - s^2) <= s+1

tableFromLines lines model =
  let
    lines = circleLines model
    rows = List.map row lines
    row line = tr [] (List.map cell line)
    cell content = td [style cellStyle] [text content]
  in
  table [style tableStyle] rows

slider { makeMsg, minValue, maxValue, model } =
  div []
    [ text <| toString minValue
    , input
      [ type_ "range"
      , A.min <| toString minValue
      , A.max <| toString maxValue
      , value <| toString model
      , onInput (makeMsg << Result.withDefault 0 << String.toInt)
      ] []
    , text <| toString maxValue
    ]


{-- styling --}

tableStyle =
    [ ("border","2px solid black")
    ]

cellStyle =
  [ ("border", "0px solid grey")
   ,("width", "10px")
   ,("height", "20px")
   ,("text-align", "center")
  ]
