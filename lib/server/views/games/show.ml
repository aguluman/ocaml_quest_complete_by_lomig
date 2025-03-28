open Containers
open Domain
open Pure_html
open Pure_html.HTML

type data =
  { title : string
  ; release_date : string
  ; rating : string
  ; platform : string
  ; genre : string
  ; cover_url : string
  ; completion_date : string
  ; review : string
  }

let extract_data_from (game : Game.t) =
  { title = game.title
  ; release_date = Date.to_short game.release_date
  ; rating =
      (match game.rating with
       | None -> "N/A"
       | Some r -> string_of_int r)
  ; platform = Platform.to_string game.platform
  ; genre = game.genre
  ; cover_url = game.cover_url
  ; completion_date = Date.to_long game.completion_date
  ; review = Option.get_or ~default:"Pas encore de critique" game.review
  }
;;



let render game =
  let data = extract_data_from game in
  Layouts.Main.layout
    [ h1
        [ class_ "text-red-800 text-4xl"; string_attr "data-controller" "hello-world" ]
        [ txt "%s" data.title ]
    ; img [ src "%s" data.cover_url; alt "%s" data.title; class_ "w-1/4" ]
    ; ul
        [ class_ "mt-4 space-y-2" ]
        [ li [] [ strong [] [ txt "Release Date: " ]; txt "%s" data.release_date ]
        ; li [] [ strong [] [ txt "Platform: " ]; txt "%s" data.platform ]
        ; li [] [ strong [] [ txt "Genre: " ]; txt "%s" data.genre ]
        ; li [] [ strong [] [ txt "Rating: " ]; txt "%s" data.rating ]
        ; li [] [ strong [] [ txt "Completed on: " ]; txt "%s" data.completion_date ]
        ]
    ; div 
        [ class_ "mt-6" ]
        [ h2 [ class_ "text-2xl" ] [ txt "Review" ]
        ; p [ class_ "mt-2" ] [ txt "%s" data.review ]
        ]
    ]
  |> to_string
