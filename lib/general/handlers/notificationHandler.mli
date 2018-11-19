module type S = sig
  type params

  val handle : params -> unit
end

val handle : NotificationMessage.t -> unit