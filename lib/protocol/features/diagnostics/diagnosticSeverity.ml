(** This type describes severity *)
open Json

type t = Error | Warning | Information | Hint

let to_yojson = function
  | Error -> i 1
  | Warning -> i 2
  | Information -> i 3
  | Hint -> i 4

let of_yojson = function
  | `Int 1 | `Float 1. -> Ok Error
  | `Int 2 | `Float 2. -> Ok Warning
  | `Int 3 | `Float 3. -> Ok Information
  | `Int 4 | `Float 4. -> Ok Hint
  | j ->
    Result.Error
      (Printf.sprintf
        "Invalid Diagnositc Severity %s"
        (json_to_string j))
