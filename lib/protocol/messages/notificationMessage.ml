open YojsonShort

(* Since there's no id the type is directly method + params *)
type t =
  | NExit
  | NInitialized
  | NDidOpen of DidOpen.Params.t
  | NDidClose of DidClose.Params.t
  | NDidChange of DidChange.Params.t
  | NPublishDiagnostics of PublishDiagnostics.Params.t

let to_yojson = function
  | NExit ->
      o [("method", s "exit")]
  | NInitialized ->
      o [("method", s "initialized")]
  | NDidOpen params ->
      o
        [ ("method", s "textDocument/didOpen")
        ; ("params", DidOpen.Params.to_yojson params) ]
  | NDidClose params ->
      o
        [ ("method", s "textDocument/didOpen")
        ; ("params", DidClose.Params.to_yojson params) ]
  | NDidChange params ->
      o
        [ ("method", s "textDocument/didChange")
        ; ("params", DidChange.Params.to_yojson params) ]
  | NPublishDiagnostics params ->
      o
        [ ("method", s "textDocument/publishDiagnostics")
        ; ("params", PublishDiagnostics.Params.to_yojson params) ]

let ( |+> ) result f =
  match result with
  | Ok x ->
      f x
  | Error s ->
      Error (ErrorCodes.InvalidParams s)

let of_yojson json =
  match json % "method" with
  | Some (`String "initialized") ->
      Ok NInitialized
  | Some (`String "exit") ->
      Ok NExit
  | Some (`String "textDocument/didOpen") -> (
    match json % "params" with
    | None ->
        Error
          (ErrorCodes.InvalidParams
             "Cannot invoke textDocument/didOpen without params")
    | Some params ->
        DidOpen.Params.of_yojson params |+> fun x -> Ok (NDidOpen x) )
  | Some (`String "textDocument/didClose") -> (
    match json % "params" with
    | None ->
        Error
          (ErrorCodes.InvalidParams
             "Cannot invoke textDocument/didClose without params")
    | Some params ->
        DidClose.Params.of_yojson params |+> fun x -> Ok (NDidClose x) )
  | Some (`String "textDocument/didChange") -> (
    match json % "params" with
    | None ->
        Error
          (ErrorCodes.InvalidParams
             "Cannot invoke textDocument/didClose without params")
    | Some params ->
        DidChange.Params.of_yojson params |+> fun x -> Ok (NDidChange x) )
  | Some (`String "textDocument/publishDiagnostics") -> (
    match json % "params" with
    | None ->
        Error
          (ErrorCodes.InvalidParams
             "Cannot invoke textDocument/publishDiagnostics without params")
    | Some params ->
        PublishDiagnostics.Params.of_yojson params
        |+> fun x -> Ok (NPublishDiagnostics x) )
  | Some j when is_s j ->
      Error (ErrorCodes.MethodNotFound "Not implemented yet")
  | _ ->
      Error (ErrorCodes.InvalidRequest "Method is incorrect")
