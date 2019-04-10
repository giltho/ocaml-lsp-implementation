module Params : sig
  type t = {
    textDocument : TextDocument.Item.t  (** The document that was opened. *)
  }
  [@@deriving yojson]
end

module Handler (P : Hooks.S) :
  Feature.NotifHandler_S with type params = Params.t
