open Handlers

let routes =
  [ Dream.get "/" Pages.homepage
  ; Dream.get "/games" Games.index
  ; Dream.get "/games/:id" Games.show
  ]
;;
