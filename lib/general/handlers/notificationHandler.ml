module type S = sig
  type params

  val handle : params -> unit
end

let handle =
  NotificationMessage.(
  function
  | NExit -> Exit.exit ()
  | NInitialized -> ()
  )