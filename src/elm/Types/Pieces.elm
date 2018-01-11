module Types.Pieces exposing (..)

import Random exposing (Generator)
import Types exposing (..)
import Svg.Symbol.Types exposing (Pieces(..))
import Svg.Symbol.ElmLogo exposing (size)


model : List Piece
model =
    [ Piece (getCenter One) 0 One
    , Piece (getCenter Two) 0 Two
    , Piece (getCenter Three) 0 Three
    , Piece (getCenter Four) 0 Four
    , Piece (getCenter Five) 0 Five
    , Piece (getCenter Six) 0 Six
    , Piece (getCenter Seven) 0 Seven
    ]


getCenter : Pieces -> Position
getCenter piece =
    case piece of
        All ->
            { x = size.width / 2, y = size.height / 2 }

        One ->
            { x = 179.573 + (323.298 - 179.573) / 2, y = 143.724 / 2 }

        Two ->
            { x = 8.867 + (232.213 - 8.867) / 2, y = 70.375 / 2 }

        Three ->
            { x = 91.783 + (231.514 - 91.783) / 2, y = 82.916 + (152.782 - 82.916) / 2 }

        Four ->
            { x = 192.99 + 107.676 / 2, y = 107.392 + 108.167 / 2 }

        Five ->
            { x = 255.522 + (323.298 - 255.522) / 2, y = 178.879 + (314.432 - 178.879) / 2 }

        Six ->
            { x = 152.781 / 2, y = 8.868 + (314.432 - 8.868) / 2 }

        Seven ->
            { x = 8.869 + (314.43 - 8.869) / 2, y = 170.517 + (323.298 - 170.517) / 2 }



---- Random ----


positionGenerator : Size -> Generator Position
positionGenerator { width, height } =
    Random.map2 Position
        (Random.float 20 <| toFloat <| width - 20)
        (Random.float 20 <| toFloat <| height - 20)


degreeGenerator : Generator Float
degreeGenerator =
    Random.int 0 (360 // 5 - 1)
        |> Random.map (\int -> toFloat int * 5)


toPiecesGenerator : Size -> Generator (List (Pieces -> Piece))
toPiecesGenerator size =
    Random.map2 Piece (positionGenerator size) degreeGenerator
        |> Random.list 7


piecesGenerator : Size -> Generator (List Piece)
piecesGenerator size =
    toPiecesGenerator size
        |> Random.map
            (\toPieces ->
                List.map2 (\toPiece piece -> toPiece piece)
                    toPieces
                    [ One, Two, Three, Four, Five, Six, Seven ]
            )
