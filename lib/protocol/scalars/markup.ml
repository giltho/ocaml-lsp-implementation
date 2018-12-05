type markupKind = Markdown | Plaintext

let markupKind_of_yojson json =
  match json with
  | `String "markdown" -> Ok Markdown
  | `String "plaintext" -> Ok Plaintext
  | _ -> Error "markupKind"

let markupKind_to_yojson = function
  | Markdown -> `String "markdown"
  | Plaintext -> `String "plaintext"

type markupContent = {kind: markupKind; value: string}
[@@deriving yojson {strict= false}]
