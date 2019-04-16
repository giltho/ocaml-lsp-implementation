module Make () : sig
  val handle : RequestMessage.t -> ResponseMessage.t Lwt.t
end
