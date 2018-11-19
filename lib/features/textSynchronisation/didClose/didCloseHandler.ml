open DidCloseParams

type params = DidCloseParams.t

let handle { textDocument } =
  TextDocuments.close_id textDocument;
  ()