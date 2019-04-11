type t = {
  textDocument : TextDocument.VersionedIdentifier.t;
  contentChanges : TextDocument.ContentChangeEvent.t list
}
[@@deriving yojson]
