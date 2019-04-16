module Make (Hooks : Hooks.S) : sig
  val handle : RequestMessage.t -> ResponseMessage.t Lwt.t
end
