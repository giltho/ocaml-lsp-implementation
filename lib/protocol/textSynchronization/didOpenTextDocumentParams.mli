type t = {
  textDocument : TextDocumentItem.t  (** The document that was opened. *)
}
[@@deriving yojson]
