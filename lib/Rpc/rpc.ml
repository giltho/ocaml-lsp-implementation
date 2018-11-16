open Result
let read_message ~log input =
  let clength = input_line input in
  let cl = "Content-Length: " in
  let cll = String.length cl in
  if (String.sub clength 0 cll) = cl
  then
    let offset = match Sys.os_type with "Win32" -> 0 | _ -> -1 in
    let numstr = String.sub clength cll (((String.length clength) - cll) + offset) in
    let num = (int_of_string numstr) + (match Sys.os_type with "Win32" -> 1 | _ -> 2) in
    (* num is supposedly the length of the json message *)
    let buffer = Buffer.create num in
    Buffer.add_channel buffer input num;
    let raw = Buffer.contents buffer in
    let json_or_error =
      try Ok (YojsonShort.parse raw)
      with
      | Failure (message) ->
        Error (ErrorCodes.ParseError (Printf.sprintf "Cannot parse: %s as json" raw))
      | err ->
        Error (ErrorCodes.InternalError (Printf.sprintf "Failure : %s" (Printexc.to_string err)))
    in
    json_or_error
  else Error (ErrorCodes.ParseError (Printf.sprintf "Invalid header"))