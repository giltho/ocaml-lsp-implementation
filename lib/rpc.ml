open YojsonShort

let read_message log input =
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
    (Buffer.add_channel buffer input num;
     (let raw = Buffer.contents buffer in
      log ((("Read message ")[@reason.raw_literal "Read message "]) ^ raw);
      (let json =
         try Json.parse raw
         with
         | ((Failure (message))[@explicit_arity ]) ->
             failwith
               ((("Unable to parse message ")[@reason.raw_literal
                                               "Unable to parse message "])
                  ^
                  (raw ^
                     (((" as json: ")[@reason.raw_literal " as json: "]) ^
                        message)))
         | err ->
             failwith
               ((("Other failure ")[@reason.raw_literal "Other failure "]) ^
                  (raw ^
                     (((" message ")[@reason.raw_literal " message "]) ^
                        (Printexc.to_string err)))) in
       messageFromJson json)))
  else failwith (("Invalid header")[@reason.raw_literal "Invalid header"])