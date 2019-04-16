type t = {
  textDocument : TextDocumentIdentifier.t  (** The document that was closed *)
}
[@@deriving yojson]
