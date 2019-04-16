type t = {
  textDocument : VersionedTextDocumentIdentifier.t;
  contentChanges : TextDocumentContentChangeEvent.t list
}
[@@deriving yojson]
