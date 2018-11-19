type t

val find_opt : CUri.t -> TextDocumentItem.t option

val open_t : TextDocumentItem.t -> unit

val close : CUri.t -> unit
