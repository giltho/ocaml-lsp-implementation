module Make (P : Hooks.S) : sig
  val handle : NotificationMessage.t -> unit
end