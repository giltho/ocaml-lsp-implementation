(** This module describes utils that allow to manipulate
    text documents *)

(** The module identifier contains the TextDocument.Identifier type *)
module Identifier : sig

  type t = {
    uri: CUri.t
    (** The text document's URI *)
  }[@@deriving yojson]

end

module Item : sig

  (** An item to transfer a text document from the client to the server. *)
  type t = {

    (** The text document's URI. *)
    uri: CUri.t;

    (** The text document's language identifier. *)
    languageId: string;

    (** The version number of this document (it will increase after each
        	    change, including undo/redo). *)
    version: int;

    (** The content of the opened text document. *)
    text: string;
  }[@@deriving yojson]

end


module Manager : sig

  (** Returns an Item given a Uri, if there is one corresponding to said
      uri in the manager *)
  val find_opt_uri : CUri.t -> Item.t option

  (** Returns an Item given an Identifier, if there is one corresponding to said
      uri in the manager *)
  val find_opt_id : Identifier.t -> Item.t option

  (** adds an Item to the manager *)
  val open_item : Item.t -> unit

  (** removes the Item corresponding to a given uri from manager *)
  val close : CUri.t -> unit

  (** removes the Item corresponding to a given identifier from the manager *)
  val close_id : Identifier.t -> unit


end
