(** The State module contains informations about the state of the language
    server. In particular, it should be initialized with the first request *)

val initialize :
  initialize_params:Protocol.InitializeParams.t ->
  unit ->
  unit
(** Function that should be called to initialize the server *)

val initialized : unit -> bool
(** Returns true if the initialize request has been received, false otherwise *)
