module Manager : sig
  val find_opt_uri : DocumentUri.t -> Item.t option
  (** Returns an Item given a DocumentUri, if there is one corresponding to said uri in
      the manager *)

  val find_opt_id : Identifier.t -> Item.t option
  (** Returns an Item given an Identifier, if there is one corresponding to
      said identifier in the manager *)

  val find_opt_vid : VersionedIdentifier.t -> Item.t option
  (** Returns an Item given a VersionedIdentifier if ther is one corresponding
      to said versioned identifier in the manager *)

  val open_item : Item.t -> unit
  (** adds an Item to the manager *)

  val close : DocumentUri.t -> unit
  (** removes the Item corresponding to a given uri from manager *)

  val close_id : Identifier.t -> unit
  (** removes the Item corresponding to a given identifier from the manager *)

  val perform_changes :
    VersionedIdentifier.t -> ContentChangeEvent.t list -> Item.t option
  (** Given a versioned identifier and a list of change event, modifies the
      content of the textDocument in the manager and returns the updated
      textDocumentItem. Returns None if the text document was not opened *)
end
