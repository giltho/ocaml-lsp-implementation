open DidOpenParams
open TextDocument.Item

type params = DidOpenParams.t

let handle { textDocument } =
  TextDocument.Manager.open_item textDocument;
  ()