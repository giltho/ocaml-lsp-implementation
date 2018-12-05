module Params = struct

  type t = {
    textDocument: TextDocument.Item.t;
  }[@@deriving yojson]

end


module Handler (P : Hooks.S) = struct

  open Params

  type params = Params.t

  let handle { textDocument } =
    TextDocument.Manager.open_item textDocument;
    P.onDidChangeContent textDocument;
    ()

end