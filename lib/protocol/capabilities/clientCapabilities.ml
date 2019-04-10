type t = {
  textDocument :
    (TextDocumentClientCapabilities.t[@default
                                       TextDocumentClientCapabilities.default])
}
[@@deriving yojson { strict = false }]

let default = Result.get (of_yojson (`Assoc []))
