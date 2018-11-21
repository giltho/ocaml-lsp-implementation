module type S = sig
  val diagnose : CUri.t -> Diagnostic.t list -> unit
end


let diagnose uri diagnostics =
  let params = PublishDiagnostics.Params.{ uri; diagnostics } in
  let message = Message.MNotification (NotificationMessage.NPublishDiagnostics params) in
  Rpc.write_yojson (Message.to_yojson message)

