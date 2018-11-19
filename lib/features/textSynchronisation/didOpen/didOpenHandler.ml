open DidOpenParams
open TextDocumentItem

type params = DidOpenParams.t

let handle { textDocument } =
  TextDocuments.open_item textDocument;
  ()