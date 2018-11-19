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