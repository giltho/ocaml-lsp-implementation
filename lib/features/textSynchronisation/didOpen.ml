module Params = struct

  type t = {
    textDocument: TextDocument.Item.t;
  }[@@deriving yojson]

end


module Handler = struct

  open Params
  open TextDocument.Item

  type params = Params.t

  let handle { textDocument } =
    TextDocument.Manager.open_item textDocument;
    ()

end