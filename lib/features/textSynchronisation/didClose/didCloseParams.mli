type t = {
  (** The document that was closed *)
  textDocument: TextDocumentIdentifier.t;
}[@@deriving yojson]