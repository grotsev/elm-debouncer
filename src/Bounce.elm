module Bounce exposing (Bounce, delay, init, pop, push, steady)

{-|


# Bounce

The most simple debouncer for Elm.

-}

import Process
import Task


type Bounce
    = Bounce Int


{-| Initial steady state.
-}
init : Bounce
init =
    Bounce 0


{-| Count new user event.
-}
push : Bounce -> Bounce
push (Bounce counter) =
    Bounce (counter + 1)


{-| Count delayed event.
-}
pop : Bounce -> Bounce
pop (Bounce counter) =
    Bounce (counter - 1)


{-| State is steady, i.e. there is no in-flight events.
-}
steady : Bounce -> Bool
steady (Bounce counter) =
    counter == 0


{-| Delay event, time in milliseconds.
-}
delay : Float -> msg -> Cmd msg
delay milliseconds msg =
    Task.perform (always msg) (Process.sleep milliseconds)
