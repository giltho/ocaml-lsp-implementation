type t = Markdown | Plaintext

let of_yojson (json: Json.json) : (t, string) result =
  match json with
  | `String "markdown" -> Ok Markdown
  | `String "plaintext" -> Ok Plaintext
  | _ -> Error "markupKind"

let to_yojson : t -> Json.json = function
  | Markdown -> `String "markdown"
  | Plaintext -> `String "plaintext"