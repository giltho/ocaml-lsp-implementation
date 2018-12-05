type t =
  { textDocumentSync: TextDocumentSyncOptions.t
  ; hoverProvider: bool
  ; definitionProvider: bool
  ; completionProvider: CompletionOptions.t }
[@@deriving yojson]

let implemented =
  { textDocumentSync= TextDocumentSyncOptions.implemented
  ; hoverProvider= false
  ; definitionProvider= false
  ; completionProvider= CompletionOptions.implemented }
