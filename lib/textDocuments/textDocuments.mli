type t

val find_opt_uri : CUri.t -> TextDocumentItem.t option

val find_opt_id : TextDocumentIdentifier.t -> TextDocumentItem.t option

val open_item : TextDocumentItem.t -> unit

val close : CUri.t -> unit

val close_id : TextDocumentIdentifier.t -> unit
