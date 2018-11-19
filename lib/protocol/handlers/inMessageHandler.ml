let handle in_message_r =
  match in_message_r with
  | Ok in_message ->
    Message.(
      match in_message with 
      | MRequest rm -> 
         let response = RequestHandler.handle rm in
        [Action.Respond response]
      | MNotification nm ->
        let () = NotificationHandler.handle nm in
        []
      | _ -> []
    )
  | Error error_code -> []