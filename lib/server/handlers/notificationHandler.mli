module Make (Hooks : Hooks.S) : sig
  val handle : NotificationMessage.t -> unit Lwt.t
end
