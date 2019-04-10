module Params : sig
  type t = {
    textDocument : TextDocument.Identifier.t
        (** The document that was closed *)
  }
  [@@deriving yojson]
end

module Handler : Feature.NotifHandler_S with type params = Params.t
