type t = {
  textDocument : TextDocument.Item.t  (** The document that was opened. *)
}
[@@deriving yojson]
