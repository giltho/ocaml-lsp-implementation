module Params : sig

  type t = {
    (** The document that was closed *)
    textDocument: TextDocument.Identifier.t;
  }[@@deriving yojson]

end

module Handler :
  Feature.NotifHandler_S
  with type params = Params.t