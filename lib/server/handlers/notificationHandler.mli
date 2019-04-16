module Make () : sig
  val handle : NotificationMessage.t -> unit Lwt.t
end
