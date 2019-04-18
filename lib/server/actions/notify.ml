let send_notification notif =
  Rpc.write_yojson
    ~channel:(State.Internal.client_channel) 
    (Protocol.NotificationMessage.to_yojson notif)

let publishDiagnostics params =
  let notification = Protocol.NotificationMessage.NPublishDiagnostics params in
  send_notification notification