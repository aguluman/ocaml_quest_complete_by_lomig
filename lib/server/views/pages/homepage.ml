open Pure_html
open Pure_html.HTML


let render title =
  Layouts.Main.layout
    [ div [ class_ "flex flex-col items-center" ]
      [ h1 [ class_ "text-purple-400 text-3xl font-bold mb-4" ] [ txt "Welcome to Quest Complete" ]
      ; div [ class_ "w-64 md:w-80 mb-6" ]
        [ img 
            [ src "https://images.igdb.com/igdb/image/upload/t_cover_big/co3p2d.jpg"
            ; alt "The Legend of Zelda: Breath of the Wild"
            ; class_ "w-full rounded-lg shadow-lg"
            ]
        ]
      ; p [ class_ "text-lg mb-4 text-center" ] [ txt "%s" title ]
      ; a 
          [ href "/games"
          ; class_ "bg-purple-600 hover:bg-purple-700 px-6 py-3 rounded-lg transition" 
          ] 
          [ txt "View All Games" ]
      ]
    ]
  |> to_string
;;
