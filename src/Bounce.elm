module Bounce exposing
    ( Bounce, steady
    , init, push, pop
    , delay
    )

{-|


# Bounce state

The most simple debouncer for Elm.

@docs Bounce, steady


# State manipulation

@docs init, push, pop


# Command

@docs delay

-}

import Process
import Task


{-| Event counter counts in-flight events
-}
type Bounce
    = Bounce Int


{-| State is steady, i.e. there is no in-flight events.
-}
steady : Bounce -> Bool
steady (Bounce counter) =
    counter == 0


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


{-| Delay event, time in milliseconds.
-}
delay : Float -> msg -> Cmd msg
delay milliseconds msg =
    Task.perform (always msg) (Process.sleep milliseconds)
