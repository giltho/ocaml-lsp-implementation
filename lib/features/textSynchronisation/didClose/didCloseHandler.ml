open DidCloseParams

type params = DidCloseParams.t

let handle { textDocument } =
  TextDocument.Manager.close_id textDocument;
  ()