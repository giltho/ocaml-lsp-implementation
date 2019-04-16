(** Defines server capabilities *)
type t = {
  textDocumentSync : TextDocumentSyncOptions.t;
  hoverProvider : bool;
  definitionProvider : bool;
  completionProvider : CompletionOptions.t option
}
[@@deriving yojson]
