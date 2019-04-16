module Make (Hooks:Hooks.S) = struct
  module RequestHandler = RequestHandler.Make (Hooks)

  module NotificationHandler = NotificationHandler.Make (Hooks)

  let handle in_message =
    let open Message in
    match in_message with
    | MRequest rm ->
        (* If it is a request, get the response and answer *)
        let%lwt response = RequestHandler.handle rm in
        Rpc.write_yojson (Message.to_yojson (Message.MResponse response))
    | MNotification nm ->
        (* If it is a notification, simply start the handler *)
        NotificationHandler.handle nm
    | _ -> Lwt.return ()
end
