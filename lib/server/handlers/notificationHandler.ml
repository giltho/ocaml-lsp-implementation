(* module Make (P : sig
  val onDidChangeContent : TextDocument.Item.t -> unit
end) =
struct
  module DidChangeHandler = DidChange.Handler (P)
  module DidOpenHandler = DidOpen.Handler (P)

  let handle =
    NotificationMessage.(
      function
      | NExit -> Exit.exit ()
      | NInitialized -> ()
      | NDidOpen params -> DidOpenHandler.handle params
      | NDidClose params -> DidClose.Handler.handle params
      | NDidChange params -> DidChangeHandler.handle params
      | NPublishDiagnostics _params ->
          failwith "Client should not publish diagnostics")
end *)

module Make () = struct

  type 'b or_error = ('b, ErrorCodes.t) result
  type 'a handler = 'a -> unit or_error Lwt.t

  let initializedHandler () =
    Lwt.return (Ok ())

  let didOpenHandler _ =
    Lwt.return (Ok ())

  let didCloseHandler _ =
    Lwt.return (Ok ())

  let didChangeHandler _ =
    Lwt.return (Ok ())

  let log_error _ = Lwt.return ()

  (* This function takes a request message "method", and returns :
   - the params
   - the associated handler
   - The Success Data Constructor for the response *)
  let destruct : NotificationMessage.t -> 'a * 'a handler=
  let open NotificationMessage in
  function
  | NInitialized -> (), initializedHandler


  let handle notfiMessage =
    let param, handler = destruct notfiMessage in
    let%lwt result = handler param in
    match result with
    | Ok () -> Lwt.return ()
    | Error ec -> log_error ec

end