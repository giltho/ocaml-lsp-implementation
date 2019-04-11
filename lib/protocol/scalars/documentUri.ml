include Uri

let of_yojson = function
  | `String s -> Ok (of_string s)
  | j -> Error ("DocumentUri " ^ Json.json_to_string j ^ " should be a string")

let to_yojson u = `String (to_string u)
