type t = {
  (** The document that was closed *)
  textDocument: TextDocument.Identifier.t;
}[@@deriving yojson]