(** The State module contains informations about the state of the language server.
    In particular, it should be initialized with the first request *)

val initialize : int -> Uri.t -> General_types.client_capabilities -> unit

val initialized : unit -> bool

val get_current_uri : unit -> Uri.t