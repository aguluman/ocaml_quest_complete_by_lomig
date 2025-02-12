open Lwt.Syntax

let system_to_version () =
  match Sys.os_type with
  | "Win32"  -> "tailwindcss-windows-x64.exe"
  | "Unix"   -> "tailwindcss-linux-x64"
  | "Cygwin" -> "tailwindcss-windows-x64.exe"
  | _        -> "tailwindcss-windows-x64.exe"

;;

let rec download_with_redirects ~max_redirects uri target =
  if max_redirects <= 0
  then Lwt.fail_with "Too many redirects"
  else
    let* resp, body = Cohttp_lwt_unix.Client.get uri in
    let code = Cohttp.Response.status resp |> Cohttp.Code.code_of_status in
    match code with
    | 200 ->
      let stream = Cohttp_lwt.Body.to_stream body in
      Lwt_io.with_file ~mode:Lwt_io.output target (fun chan ->
        Lwt_stream.iter_s (Lwt_io.write chan) stream)
    | 301 | 302 | 307 | 308 ->
      (match Cohttp.Header.get (Cohttp.Response.headers resp) "location" with
       | Some location ->
         let new_uri = Uri.of_string location in
         download_with_redirects ~max_redirects:(max_redirects - 1) new_uri target
       | None -> Lwt.fail_with "Redirection response missing Location header")
    | _ -> Lwt.fail_with (Printf.sprintf "Failed to download: HTTP %d" code)
;;

let () =
  let target = Filename.concat Sys.argv.(1) "tailwindcss" in
  let version = system_to_version () in
  let base_url =
    "https://github.com/tailwindlabs/tailwindcss/releases/latest/download/"
  in
  let uri = Uri.of_string (base_url ^ version) in
  Lwt_main.run @@ download_with_redirects ~max_redirects:5 uri target
;;