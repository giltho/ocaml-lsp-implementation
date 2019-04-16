(* module Make (P : sig val onDidChangeContent : TextDocument.Item.t -> unit
   end) = struct module DidChangeHandler = DidChange.Handler (P) module
   DidOpenHandler = DidOpen.Handler (P)

   let handle = NotificationMessage.( function | NExit -> Exit.exit () |
   NInitialized -> () | NDidOpen params -> DidOpenHandler.handle params |
   NDidClose params -> DidClose.Handler.handle params | NDidChange params ->
   DidChangeHandler.handle params | NPublishDiagnostics _params -> failwith
   "Client should not publish diagnostics") end *)

module Make () = struct
  type 'b or_error = ('b, ErrorCodes.t) result

  type 'a handler = 'a -> unit or_error Lwt.t

  let initializedHandler () = Lwt.return (Ok ())

  let didOpenTextDocumentHandler (_ : DidOpenTextDocumentParams.t) =
    Lwt.return (Ok ())

  let didCloseTextDocumentHandler _ = Lwt.return (Ok ())

  let didChangeTextDocumentHandler _ = Lwt.return (Ok ())

  let unknownNotificationHandler _ =
    Lwt.return (Error (ErrorCodes.MethodNotFound "Unkown method"))

  let log_error _ = Lwt.return ()

  let handling params handler =
    let%lwt result = handler params in
    match result with Ok () -> Lwt.return () | Error ec -> log_error ec

  let handle notifMessage =
    let open NotificationMessage in
    match notifMessage with
    | NInitialized -> handling () initializedHandler
    | NDidOpenTextDocument params -> handling params didOpenTextDocumentHandler
    | NDidChangeTextDocument params ->
        handling params didChangeTextDocumentHandler
    | NDidCloseTextDocument params ->
        handling params didCloseTextDocumentHandler
    | _ -> handling () unknownNotificationHandler
end
