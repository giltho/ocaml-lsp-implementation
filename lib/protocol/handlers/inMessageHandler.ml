module Make (P : Hooks.S) = struct
  module NotificationHandler = NotificationHandler.Make (P)

  let handle in_message_r =
    match in_message_r with
    | Ok in_message -> (
        Message.(
          match in_message with
          | MRequest rm ->
              (* If it is a request, get the response and answer *)
              let response = RequestHandler.handle rm in
              Rpc.write_yojson (Message.to_yojson (Message.MResponse response))
          | MNotification nm ->
              (* If it is a notification, simply start the handler *)
              NotificationHandler.handle nm
          | _ -> ()) )
    | Error _error_code -> ()
end
