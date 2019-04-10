module Params = struct
  type t = { textDocument : TextDocument.Identifier.t } [@@deriving yojson]
end

module Handler = struct
  open Params

  type params = Params.t

  let handle { textDocument } =
    TextDocument.Manager.close_id textDocument;
    ()
end
