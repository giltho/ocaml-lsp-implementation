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

  let didOpenTextDocumentHandler (params : DidOpenTextDocumentParams.t) =
    let DidOpenTextDocumentParams.{ textDocument } = params in
    let () = State.DocumentManager.open_item textDocument in
    Lwt.return (Ok ())

  let didCloseTextDocumentHandler params =
    let DidCloseTextDocumentParams.{ textDocument } = params in
    let () = State.DocumentManager.close_id textDocument in
    Lwt.return (Ok ())

  let didChangeTextDocumentHandler params =
    let DidChangeTextDocumentParams.{ textDocument; contentChanges } =
      params
    in
    let newDocument =
      State.DocumentManager.perform_changes textDocument contentChanges
    in
    let _ =
      match newDocument with
      | Error _ -> Lwt.return ()
      | Ok doc ->
          Actions.Log.log
            (Printf.sprintf "NEW DOC: %s" doc.TextDocumentItem.text)
    in
    Lwt.return (Ok ())

  let unknownNotificationHandler _ =
    Lwt.return
      (Error
         (ErrorCodes.InvalidRequest
            "This method should be server to client only"))

  let handling params handler =
    let%lwt result = handler params in
    match result with
    | Ok () -> Lwt.return ()
    | Error ec -> Actions.Log.log_error ec

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
