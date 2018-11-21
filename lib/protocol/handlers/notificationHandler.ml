let handle =
  NotificationMessage.(
    function
    | NExit -> Exit.exit ()
    | NInitialized -> ()
    | NDidOpen params -> DidOpen.Handler.handle params
    | NDidClose params -> DidClose.Handler.handle params
    | NDidChange params -> DidChange.Handler.handle params
    | NPublishDiagnostics _params -> failwith "Client should not publish diagnostics"
  )