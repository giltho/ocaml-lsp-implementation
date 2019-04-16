(** This file contains the function that handles a received message *)

module Make (Hooks : Hooks.S) : sig
  val handle : Protocol.Message.t -> unit Lwt.t
end
