type t = {
    textDocument : TextDocument.Identifier.t
        (** The document that was closed *)
  }
  [@@deriving yojson]
