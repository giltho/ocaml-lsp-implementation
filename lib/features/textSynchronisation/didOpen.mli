module Params : sig

  type t = {
    (** The document that was opened. *)
    textDocument: TextDocument.Item.t;
  }[@@deriving yojson]

end

module Handler : Feature.NotifHandler_S
  with type params = Params.t