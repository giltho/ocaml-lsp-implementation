type t = {
  (** The document that was opened. *)
  textDocument: TextDocumentItem.t;
}[@@deriving yojson]