let handle =
  NotificationMessage.(
  function
  | NExit -> Exit.exit ()
  | NInitialized -> ()
  | NDidOpen params -> DidOpenHandler.handle params
  | NDidClose params -> DidCloseHandler.handle params
  )