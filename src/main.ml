open Eliom_content
open Html5.F

module Dom_type =
  Eliom_registration.App (struct
    let application_name = "dom_type"
  end)


let html_v cl =
  html ~a:[ a_manifest (uri_of_string (fun () -> "/cache.manifest")) ]
    (head
       (title (pcdata "OChip8")) [
       meta ~a:([a_charset "utf-8"; a_content "text/html"; a_http_equiv "Content-Type"]) () ;
       meta ~a:([a_name "Description"; a_content "Html representation of ocaml type"]) () ;
       meta ~a:([a_property "og:type"; a_content "website"]) () ;
       meta ~a:([a_property "og:url"; a_content ("http://www.chip8.com/dom_type")]) () ;
       meta ~a:([a_property "og:title"; a_content "Dom Type"]) () ;
       meta ~a:([a_property "og:site_name"; a_content "Dome Type"]) () ;

       link ~rel:[ `Stylesheet ] ~href:(uri_of_string (fun () -> "/bootstrap.min.css")) ();
       link ~rel:[ `Stylesheet ] ~href:(uri_of_string (fun () -> "/dom_type.css")) ();
     ])
    (body ~a:[ a_class [cl]] [])

let main _ _ =
  let _ : unit client_value = {{
  Eliom_client.onload (
    fun _ ->
      Main_client.init ()
  )
  }} in

  Lwt.return (html_v "main")


let _ =
  Dom_type.register_service
    ~path:[ "" ] ~get_params:Eliom_parameter.unit
    main
