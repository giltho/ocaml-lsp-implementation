(** Defines a notification message *)

open Json

(** Defines what a notification message is *)
type t =
  | NExit
  | NInitialized
  | NDidOpenTextDocument of DidOpenTextDocumentParams.t
  | NDidCloseTextDocument of DidCloseTextDocumentParams.t
  | NDidChangeTextDocument of DidChangeTextDocumentParams.t
  | NPublishDiagnostics of PublishDiagnosticsParams.t

let to_yojson : t -> Yojson.Safe.json = function
  | NExit -> o [ ("method", s "exit") ]
  | NInitialized -> o [ ("method", s "initialized") ]
  | NDidOpenTextDocument params ->
      o
        [ ("method", s "textDocument/didOpen");
          ("params", DidOpenTextDocumentParams.to_yojson params)
        ]
  | NDidCloseTextDocument params ->
      o
        [ ("method", s "textDocument/didOpen");
          ("params", DidCloseTextDocumentParams.to_yojson params)
        ]
  | NDidChangeTextDocument params ->
      o
        [ ("method", s "textDocument/didChange");
          ("params", DidChangeTextDocumentParams.to_yojson params)
        ]
  | NPublishDiagnostics params ->
      o
        [ ("method", s "textDocument/publishDiagnostics");
          ("params", PublishDiagnosticsParams.to_yojson params)
        ]

let ( |+> ) result f =
  match result with
  | Ok x -> f x
  | Error s -> Error (ErrorCodes.InvalidParams s)

let of_yojson (json: Yojson.Safe.json) : (t, ErrorCodes.t) result =
  match json % "method" with
  | Some (`String "initialized") -> Ok NInitialized
  | Some (`String "exit") -> Ok NExit
  | Some (`String "textDocument/didOpen") -> (
    match json % "params" with
    | None ->
        Error
          (ErrorCodes.InvalidParams
             "Cannot invoke textDocument/didOpen without params")
    | Some params ->
        DidOpenTextDocumentParams.of_yojson params |+> fun x -> Ok (NDidOpenTextDocument x)
    )
  | Some (`String "textDocument/didClose") -> (
    match json % "params" with
    | None ->
        Error
          (ErrorCodes.InvalidParams
             "Cannot invoke textDocument/didClose without params")
    | Some params ->
        DidCloseTextDocumentParams.of_yojson params |+> fun x ->
        Ok (NDidCloseTextDocument x) )
  | Some (`String "textDocument/didChange") -> (
    match json % "params" with
    | None ->
        Error
          (ErrorCodes.InvalidParams
             "Cannot invoke textDocument/didClose without params")
    | Some params ->
        DidChangeTextDocumentParams.of_yojson params |+> fun x ->
        Ok (NDidChangeTextDocument x) )
  | Some (`String "textDocument/publishDiagnostics") -> (
    match json % "params" with
    | None ->
        Error
          (ErrorCodes.InvalidParams
             "Cannot invoke textDocument/publishDiagnostics without params")
    | Some params ->
        PublishDiagnosticsParams.of_yojson params |+> fun x ->
        Ok (NPublishDiagnostics x) )
  | Some j when is_s j ->
      Error (ErrorCodes.MethodNotFound "Not implemented yet")
  | _ -> Error (ErrorCodes.InvalidRequest "Method is incorrect")
