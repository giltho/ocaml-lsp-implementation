open Protocol

val find_opt_uri : DocumentUri.t -> TextDocumentItem.t option
(** Returns an Item given a DocumentUri, if there is one corresponding to said
    uri in the manager *)

val find_opt_id : TextDocumentIdentifier.t -> TextDocumentItem.t option
(** Returns an Item given an Identifier, if there is one corresponding to said
    identifier in the manager *)

val find_opt_vid :
  VersionedTextDocumentIdentifier.t -> TextDocumentItem.t option
(** Returns an Item given a VersionedIdentifier if ther is one corresponding to
    said versioned identifier in the manager *)

val open_item : TextDocumentItem.t -> unit
(** adds an Item to the manager *)

val close : DocumentUri.t -> unit
(** removes the Item corresponding to a given uri from manager *)

val close_id : TextDocumentIdentifier.t -> unit
(** removes the Item corresponding to a given identifier from the manager *)

val perform_changes :
  VersionedTextDocumentIdentifier.t ->
  TextDocumentContentChangeEvent.t list ->
  (TextDocumentItem.t, ErrorCodes.t) result
(** Given a versioned identifier and a list of change event, modifies the
    content of the textDocument in the manager and returns the updated
    textDocumentItem. *)
