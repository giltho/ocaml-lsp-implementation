type t = {
    textDocument : TextDocument.VersionedIdentifier.t;
        (** The document that did change. The version number points to the
            version after all provided content changes have been applied. *)
    contentChanges : TextDocument.ContentChangeEvent.t list
        (** The actual content changes. The content changes describe single
            state changes to the document. So if there are two content changes
            c1 and c2 for a document in state S then c1 move the document to S'
            and c2 to S''. *)
  }
[@@deriving yojson]