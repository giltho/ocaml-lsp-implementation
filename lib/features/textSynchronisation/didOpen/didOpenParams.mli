type t = {
  (** The document that was opened. *)
  textDocument: TextDocument.Item.t;
}[@@deriving yojson]