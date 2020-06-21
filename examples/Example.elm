module Example exposing (main)

import Bounce exposing (Bounce)
import Browser exposing (element)
import Html exposing (Html, div, input, text)
import Html.Attributes exposing (value)
import Html.Events exposing (onInput)


main =
    element
        { init = init
        , view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        }


type alias Model =
    { name : String
    , steadyName : String
    , bounce : Bounce
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( { name = ""
      , steadyName = ""
      , bounce = Bounce.init
      }
    , Cmd.none
    )


view : Model -> Html Msg
view { name, steadyName, bounce } =
    div []
        [ input [ onInput EditMsg, value name ] []
        , text <|
            if Bounce.steady bounce then
                ""

            else
                "typing..."
        , div [] [ text ":", text name ]
        , div [] [ text ":", text steadyName ]
        ]


type Msg
    = EditMsg String
    | BounceMsg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg ({ name, steadyName, bounce } as model) =
    case msg of
        EditMsg value ->
            ( { model
                | name = value
                , bounce = Bounce.push bounce
              }
            , Bounce.delay 1000 BounceMsg
            )

        BounceMsg ->
            let
                newBounce =
                    Bounce.pop bounce
            in
            ( { model
                | bounce = newBounce
                , steadyName =
                    if Bounce.steady newBounce then
                        name

                    else
                        steadyName
              }
            , if Bounce.steady newBounce && not (String.isEmpty name) then
                httpRequest name

              else
                Cmd.none
            )


httpRequest : String -> Cmd Msg
httpRequest name =
    Debug.log ("Send HTTP request:" ++ name) Cmd.none
