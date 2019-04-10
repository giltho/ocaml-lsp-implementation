type t = Uri.t

let of_yojson = function
  | `String s ->
      Ok (Uri.of_string s)
  | j ->
      Error ("Uri " ^ Yojson.Safe.to_string j ^ " should be a string")

let to_yojson u = `String (Uri.to_string u)
