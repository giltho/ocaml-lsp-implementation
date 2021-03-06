type t = TDSKIncremental | TDSKFull | TDSKNone

let of_yojson = function
  | `Int 0 | `Float 0. -> Ok TDSKNone
  | `Int 1 | `Float 1. -> Ok TDSKFull
  | `Int 2 | `Float 2. -> Ok TDSKIncremental
  | j ->
      Error (Json.json_to_string j ^ " is not a correct TextDocumentSyncKind")

let to_yojson = function
  | TDSKNone -> `Int 0
  | TDSKFull -> `Int 1
  | TDSKIncremental -> `Int 2
