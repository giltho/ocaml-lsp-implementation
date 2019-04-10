module Make (P : sig
  val onDidChangeContent : TextDocument.Item.t -> unit
end) =
struct
  module DidChangeHandler = DidChange.Handler (P)
  module DidOpenHandler = DidOpen.Handler (P)

  let handle =
    NotificationMessage.(
      function
      | NExit ->
          Exit.exit ()
      | NInitialized ->
          ()
      | NDidOpen params ->
          DidOpenHandler.handle params
      | NDidClose params ->
          DidClose.Handler.handle params
      | NDidChange params ->
          DidChangeHandler.handle params
      | NPublishDiagnostics _params ->
          failwith "Client should not publish diagnostics")
end
