type t = {
    textDocument: (TextDocumentClientCapabilities.t [@default TextDocumentClientCapabilities.default]);
}[@@deriving yojson { strict = false } ]