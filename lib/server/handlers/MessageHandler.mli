(** This file contains the function that handles a received message *)

module Make () : sig
  val handle : Protocol.Message.t -> unit Lwt.t
end
