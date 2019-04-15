let read_yojson () =
  let input = Lwt_io.stdin in
  let%lwt clength = Lwt_io.read_line input in
  let cl = "Content-Length: " in
  let cll = String.length cl in
  if String.sub clength 0 cll = cl then (
    let offset = match Sys.os_type with "Win32" -> 0 | _ -> -1 in
    let numstr =
      String.sub clength cll (String.length clength - cll + offset)
    in
    let num =
      int_of_string numstr + match Sys.os_type with "Win32" -> 1 | _ -> 2
    in
    (* num is supposedly the length of the json message *)
    let buffer = Bytes.create num in
    let%lwt () = Lwt_io.read_into_exactly input buffer 0 num in
    let raw = Bytes.to_string buffer in
    let json_or_error =
      try Ok (Json.parse raw) with
      | Failure message ->
          Error
            (Printf.sprintf "Cannot parse: %s as json. Message : %s" raw
                message)
    in
    Lwt.return json_or_error)
  else Lwt.return (Error (Printf.sprintf "Invalid header"))

let write_yojson outyj =
  let output = Lwt_io.stdout in
  let content = Json.json_to_string outyj in
  let sep = "\r\n\r\n" in
  let cl = String.length content in
  let cls = string_of_int cl in
  let header = Printf.sprintf "Content-Length: %s" cls in
  let message = header ^ sep ^ content in
  Lwt_io.write output message
