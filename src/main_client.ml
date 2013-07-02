{client{
  open Eliom_content
  open Html5
  open D

  let header () =
    header [
      div [
        div ~a:[ a_class ["logo_side"]] [
          span ~a:[ a_class ["logo"]] [];
          span ~a:[ a_class ["logo_txt"]] [ pcdata "DOM TYPE" ];
        ];
      ]
    ]

  let about_dom_type () =
    div ~a:[ a_class ["about_dom_type"]] [
      h2 [ pcdata "About Dom Type" ];
      div [
        p [
          span [ pcdata "Dom Type is a " ];
          Raw.a ~a:[ a_href "https://code.google.com/p/deriving/"; a_target "_blank" ] [ pcdata "deriving" ];
          span [ pcdata " syntax extenson that generate the html for complex ocaml type, and vice versa" ];
        ];
        p [
          span [
            pcdata "It is aim to easily create and modify ocaml value with a html interface. It is particularly well suit for a backend application.
(I'm fully using it to generate the backend application of my other project ";
          ];
          Raw.a ~a:[ a_href "http://www.ochip8.com"; a_target "_blank" ] [ pcdata "Ochip8" ];
          span [
            pcdata " to easily modify games configuration)"
          ]
        ]
      ]
    ]

  let organisation () =
    div ~a:[ a_class ["organisation"]] [
      h2 [ pcdata "Organisation of the project" ];
      div [
        p [
          pcdata "This project is compose of 2 tiny libraries (dom_type.client and dom_type.server) and 2 syntax extension (dom_type.client.syntax and dom_type.server.syntax)"
        ];
        p [
          span [ pcdata "Dom type being a " ];
          span ~a:[ a_class ["underline"]] [ pcdata "fully client extension" ];
          span [ pcdata ", the server side is only a dummy plugin and will be usefull in a case you are using ocsigen/eliom" ]
        ];
        div ~a:[ a_class ["code_block"]] [
          span [ pcdata "It will let you write:" ];
          pre [
            code [
              pcdata "{shared{

  type t = {
    (* type declaration *)
  } deriving (Dom_type)

}}"
            ]
          ]
        ];
        p [
          span [ pcdata "Trying to use the generated function on the server-side code will result in an "];
          span ~a:[ a_class ["underline"]] [ pcdata "assert false" ];
          span [ pcdata "." ];
        ]
      ]
    ]

  let how_does_it_work () =
    let i = Dom_type.Dom_type_int.to_default () in
    let basic_example () =
      div [
        h4 [ pcdata "Basic example" ];
        p [ pcdata "Let's start with a basic type (int,float,string,bool)" ];
        div [
          p [
            pcdata "By writting :"
          ];
          pre [
            code [
              pcdata "Dom_type.Dom_type_int.to_default ()"
            ]
          ];
          p [
            pcdata "will generate :"
          ];
          Dom_type.node i;
        ]
      ]
    in

    div ~a:[ a_class [ "how_does_it_work" ]] [
      h2 [ pcdata "How does it work ?" ];
      div [
        p [
          span [ pcdata "The syntax extension will generate 3 functions by type:"];
        ];
        ul [
          li [ pcdata "to_default () : generate the dom for the given type without any value"];
          li [ pcdata "to_dom v : genereate the dom for the given type with a initial value"];
          li [ pcdata "save d : save the dom's value to an ocaml value" ];
        ];

        basic_example ();
      ]
    ]

  let todo () =
    div ~a:[ a_class [ "todo" ]] [
      h2 [ pcdata "On my todo list" ];
      div [
        p [ pcdata "- The ability to hide/forbid the modification of certain fields of a record" ];
        p [ pcdata "- The ability to select between textarea and input for string" ];
        p [ pcdata "- Add support for extend in variant type" ];
      ]
    ]

  let main_dom () =
    div [
      header ();
      div ~a:[ a_class ["container"; "about"]] [
        about_dom_type ();
        organisation ();
        how_does_it_work ();
        todo ();
      ]
    ]

  let init _ =
    Manip.appendToBody (main_dom ())
}}
