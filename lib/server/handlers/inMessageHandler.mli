(** This file contains the function that handles a received message *)

module Make (P : Hooks.S) : sig
  val handle : Message.t result -> unit
end
