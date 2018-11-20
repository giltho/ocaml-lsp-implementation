(** This module describes utils that allow to manipulate
    text documents *)

(** The module identifier contains the TextDocument.Identifier type *)
module Identifier : sig

  type t = {
    uri: CUri.t
    (** The text document's URI *)
  }[@@deriving yojson]

end



module VersionedIdentifier : sig

  (** An identifier to denote a specific version of a text document. *)
  type t = {
    uri: CUri.t;
    (** Uri of the document *)
    version: int (* option *);
    (** The version number of this document. If a versioned text document identifier
        is sent from the server to the client and the file is not open in the editor
        (the server has not received an open notification before) the server can send
        `null` to indicate that the version is known and the content on disk is the
        truth (as speced with document content ownership).
        The version number of a document will increase after each change, including
        undo/redo. The number doesn't need to be consecutive.
	  *)
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

module ContentChangeEvent : sig

  type t = {
    range : Range.t option;
    (** The range of the document that changed. *)
    rangeLength : int option;
    (** The length of the range that got replaced. *)
    text: string;
    (** The new text of the range/textDocument *)
  }[@@deriving yojson]

end

module Manager : sig

  (** Returns an Item given a Uri, if there is one corresponding to said
      uri in the manager *)
  val find_opt_uri : CUri.t -> Item.t option

  (** Returns an Item given an Identifier, if there is one corresponding to said
      identifier in the manager *)
  val find_opt_id : Identifier.t -> Item.t option

  (** Returns an Item given a VersionedIdentifier if ther is one corresponding to said
      versioned identifier in the manager *)
  val find_opt_vid : VersionedIdentifier.t -> Item.t option

  (** adds an Item to the manager *)
  val open_item : Item.t -> unit

  (** removes the Item corresponding to a given uri from manager *)
  val close : CUri.t -> unit

  (** removes the Item corresponding to a given identifier from the manager *)
  val close_id : Identifier.t -> unit

  (** Given a versioned identifier and a list of change event,
      modifies the content of the textDocument
      in the manager and returns the updated textDocumentItem.
      Returns None if the text document was not opened *)
  val perform_changes : VersionedIdentifier.t -> ContentChangeEvent.t list -> Item.t option


end
