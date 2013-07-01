{client{
  open Eliom_content
  open Html5
  open D

  let header () = div []

  let main_dom () =
    div [
      header ();
      div ~a:[ a_class [ "container"]] [
        h1 [ pcdata "hello" ]
      ]
    ]

  let init _ =
    Manip.appendToBody (main_dom ())
}}
