type t = TOff | TMessage | TVerbose

let of_yojson = function
  | `String "off" -> Ok TOff
  | `String "message" -> Ok TMessage
  | `String "verbose" -> Ok TVerbose
  | j -> Error (Yojson.Safe.to_string j ^ " is not a valid trace parameter")

let to_yojson = function
  | TMessage -> `String "message"
  | TOff -> `String "off"
  | TVerbose -> `String "verbose"
