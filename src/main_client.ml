{client{
  open Eliom_content
  open Html5
  open D

  type tuple = (int * string * float) deriving (Dom_type)
  type variants =
    | Variant1
    | Variant2
    | Variant3 of int
    | Variant4 of string
    | Variant5 of (int * string)
    | Variant6 of variants
        deriving (Dom_type)

  module Int_list = Dom_type.Dom_type_list(Dom_type.Dom_type_int)
  module Opt_tuple = Dom_type.Dom_type_option(Dom_type_tuple)

  type emu_key = [
    | `K0 | `K1 | `K2 | `K3
  ] deriving (Dom_type)

  type key = [
    | `Key_esc | `Key_space | `Key_backspace | `Key_return
    | `Key_left | `Key_up | `Key_right | `Key_down
    | `Other of int
  ] deriving (Dom_type)

  type game = {
    name : string ;
    path : string ;
    game_rate : float option ;
    timer_rate : float option ;
    game_data : string option ;
    keys : (key * emu_key) list ;
  } deriving (Dom_type)


  let header () =
    header [
      div [
        div ~a:[ a_class ["logo_side"]] [
          span ~a:[ a_class ["logo"]] [];
          span ~a:[ a_class ["logo_txt"]] [ pcdata "DOM TYPE" ];
        ];
        Raw.a ~a:[ a_class ["github_fork"]; Raw.a_href "https://github.com/msimon/dom_type"; a_target "_blank" ] [
          img ~src:"https://s3.amazonaws.com/github/ribbons/forkme_right_gray_6d6d6d.png" ~alt:"https://github.com/msimon/chip8js" ()
        ]
      ]
    ]

  let about_dom_type () =
    div ~a:[ a_class ["about_dom_type"]] [
      h2 [ pcdata "About Dom Type" ];
      div [
        p [
          span [ pcdata "Dom Type is a " ];
          Raw.a ~a:[ a_href "https://code.google.com/p/deriving/"; a_target "_blank" ] [ pcdata "deriving" ];
          span [ pcdata " syntax extenson that generate the html for complex ocaml type, and vice versa." ];
        ];
        p [
          span [
            pcdata "It is aim to easily create and modify ocaml value with a html interface. It is particularly well suit for a backend application.
(I'm using it to fully generate the backend application of my other project ";
          ];
          Raw.a ~a:[ a_href "http://www.ochip8.com"; a_target "_blank" ] [ pcdata "Ochip8" ];
          span [
            pcdata " to easily modify games configuration)."
          ]
        ]
      ]
    ]

  let organisation () =
    div ~a:[ a_class ["organisation"]] [
      h2 [ pcdata "Organisation of the project" ];
      div [
        p [
          pcdata "This project is compose of 2 tiny libraries (dom_type.client and dom_type.server) and 2 syntax extension (dom_type.client.syntax and dom_type.server.syntax)."
        ];
        p [
          span [ pcdata "Dom type being a " ];
          span ~a:[ a_class ["underline"]] [ pcdata "fully client extension" ];
          span [ pcdata ", the server side is only a dummy plugin and will be usefull in a case you are using ocsigen/eliom." ]
        ];
        div ~a:[ a_class ["code_block"]] [
          p [ pcdata "It will let you write:" ];
          pre [
            code [
              pcdata "{shared{

  type t = {
    (* type declaration *)
  } deriving (Dom_type)

}}"
            ]
          ];
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
      div ~a:[ a_class ["code_block"]] [
        h4 [ pcdata "Basic example" ];
        p [ pcdata "Let's start with a basic type (int,float,string,bool)." ];
        p [
          pcdata "By writting:"
        ];
        pre [
          code [
            pcdata "let i = Dom_type.Dom_type_int.to_default () in
...
Dom_type.node i
"
          ]
        ];
        p [
          pcdata "will generate:"
        ];
        Dom_type.node i;
        p [
          pcdata "If you look at the generated html you should notice 2 things:"
        ];
        pre [
          code [
            pcdata "<div class=\"dom_ext_int\">
  <p class=\"error\" style=\"display:none\"></p>
  <input type=\"text\" value=\"\" />
</div>"
          ]
        ];
        ul [
          li [ pcdata "a \"dom_ext_TYPE\" class is add to let you be able to differentiate input."];
          li [ pcdata "above the input, a error dom is insert. This will display a error, at saving time, in case of empty non-optional fields or wrong type." ];
        ];
        br ();
        p [
          pcdata "Then, you can save the new value with:"
        ];
        pre [
          code [
            pcdata "Dom_type.Dom_type_int.to_save i"
          ]
        ];
      ]
    in

    let tuple () =
      let t = Dom_type_tuple.to_dom (5,"string", 1.3) in

      div ~a:[ a_class [ "code_block" ]] [
        h4 [ pcdata "Tuple" ];
        p [ pcdata "Tuple will be generate as each type it is composs of, one by one. To help differentiate them, the parent div has a class \"dom_ext_tuple\"." ];
        pre [
          code [
            pcdata "type tuple = (int * string * float) deriving (Dom_type)

...

let t = Dom_type_tuple.to_dom (5,\"string\", 1.3) in
...
Dom_type.node t;
"
          ]
        ];
        Dom_type.node t;
        p [ pcdata "Note that for non-basic type, the module (in this case Dom_type_tuple) will be add in the same file as the type definition."]
      ]
    in

    let variants () =
      let v = Dom_type_variants.to_default () in

      div ~a:[ a_class ["code_block"]] [
        h4 [ pcdata "Variants" ];
        p [
          pcdata "Variants and polymorphic variants are handle in the exact same way. Since variant can take one of severals values the html will generate a \"select\" input.
Each \"option\" (html element inside the select) represent an enumerated type.
For variants with non-enumerated type (i.e: | X of int) the necessary input will be display when selected and remove when another value is selected."
        ];
        p [
          pcdata "This example should clarify how variants work:"
        ];
        pre [
          code [
            pcdata "type variants =
  | Variant1
  | Variant2
  | Variant3 of int
  | Variant4 of string
  | Variant5 of (int * string)
  | Variant6 of variants

...

let v = Dom_type_variants.to_default () in
...
Dom_type.node v
"
          ]
        ];
        Dom_type.node v;
        p [
          pcdata "Note that for polymorphic variant, extend is not yet suported."
        ]
      ]
    in

    let list () =
      let l = Int_list.to_default () in

      div ~a:[ a_class [ "code_block" ]] [
        h4 [ pcdata "List (and array)"];
        p [
          pcdata "By writting:"
        ];
        pre [
          code [
            pcdata "module Int_list = Dom_type.Dom_type_list(Dom_type.Dom_type_int)

...

let l = Int_list.to_default () in
...
Dom_type.node l
"
          ]
        ];
        p [
          pcdata "This html will be generated:";
        ];
        Dom_type.node l;
        p [
          pcdata "Note that every empty input will not generate a error while saving, and will just be ignore."
        ]
      ]
    in

    let option () =
      let o = Opt_tuple.to_default () in
      let success_div = div ~a:[ a_style "margin-left: 60px;";] [] in

      div ~a:[ a_class ["code_block"]] [
        h4 [ pcdata "Option" ];
        p [
          pcdata "Option type will be generated like a normal type, wrap around a div with \"dom_ext_option\" class.
This feature can be tricky on complex type. At the first input that generate a empty value exception a None value will be return.
Also, the error will be display for an empty input (but catch by Dom_type_option), even if the None value is return.
Make sure you indicate somewhere that the form did success."
        ];
        p [
          pcdata "Let's take back our previous tuple type, and apply it to option:"
        ];
        pre [
          code [
            pcdata "module Opt_tuple = Dom_type.Dom_type_option(Dom_type_tuple)

...

let o = Opt_tuple.to_default () in
let success_div = div [] in
...
Dom_type.node o;
success_div ;
button ~button_type:`Button ~a:[
  a_class [\"button\"]
  a_onclick (
    fun _ ->
      Manip.replaceAllChild success_div [] ;
      let _ = Opt_tuple.save o in
      Manip.replaceAllChild success_div [ pcdata \"SAVED\" ] ;
      false
  ) ] [ pcdata \"save\"];
"
          ]
        ];
        Dom_type.node o;
        success_div ;
        button ~button_type:`Button ~a:[
          a_class ["btn"];
          a_style "margin-left: 60px;";
          a_onclick (
            fun _ ->
              Manip.replaceAllChild success_div [] ;
              let _ = Opt_tuple.save o in
              Manip.replaceAllChild success_div [ pcdata "SAVED" ] ;
              false
          ) ] [ pcdata "save"];
      ]
    in

    let record () =
      let game = Dom_type_game.to_default () in

      div ~a:[ a_class [ "code_block" ]] [
        h4 [ pcdata "Record" ];
        div [
          p [
            span [ pcdata "Record will be generated as key value reprensation. Each type the record is compose of will be generated as previously.
I am using it to add and modify games in my other project "];
            Raw.a ~a:[ a_href "http://www.ochip8.com" ; a_target "_blank"] [ pcdata "ochip8" ];
            span [ pcdata "."]
          ];
          p [
            pcdata "Let's see a simplify version of games' type:"
          ];
          pre [
            code [
              pcdata "type emu_key = [
  | `K0 | `K1 | `K2 | `K3
] deriving (Json, Json_ext)

type key = [
  | `Key_esc | `Key_space | `Key_backspace | `Key_return
  | `Key_left | `Key_up | `Key_right | `Key_down
  | `Other of int
] deriving (Json, Json_ext)

type game = {
  name : string ;
  path : string ;
  game_rate : float option ;
  timer_rate : float option ;
  game_data : string option ;
  keys : (key * emu_key) list ;
} deriving (Dom_type, Json)

...

let game = Dom_type_game.to_default () in
...
Dom_type.node game
"
            ]
          ];
          Dom_type.node game
        ];
        p [
          pcdata "In this case keys are mapping keyboard key with the chip8 interpretor. Thanks to the variant list, several keybord's key can be assign to the same chip8's key.
Also, if a keys is missing from the enumerated variant list, thanks to the `Other variant we are able to map any keyboard's key."
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
        tuple ();
        variants ();
        list ();
        option ();
        record ();
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

  let thats_all () =
    div ~a:[ a_class ["thats_all_folks"]] [
      h2 [ pcdata "That's all folks!" ];
      div [
        p [
          span [ pcdata "You can reach me on twiter " ];
          Raw.a ~a:[ a_href "https://twitter.com/marcsimon42"; a_target "_blank"] [ pcdata "@marcsimon42" ];
          span [ pcdata " for any question or issues. Don't forget to check out the project on " ];
          Raw.a ~a:[ a_href "https://github.com/msimon/dom_type"; a_target "_blank" ] [ pcdata "github" ];
          span [ pcdata " !" ];
        ]
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
        thats_all ()
      ]
    ]

  let init _ =
    Manip.appendToBody (main_dom ())
}}
