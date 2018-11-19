open YojsonShort

(* Since there's no id the type is directly method + params *)
type t =
  | NExit
  | NInitialized 
  | NDidOpen of DidOpenParams.t



let to_yojson =
  function
    | NExit -> o([
      ("method", s("exit"));
    ])
    | NInitialized -> o([
      ("method", s("initialized"))
    ])
    | NDidOpen params -> o([
      ("method", s("textDocument/didOpen"));
      ("params", DidOpenParams.to_yojson params);
    ])

let (|+>) result f =
  match result with
  | Ok x -> f x
  | Error s -> Error (ErrorCodes.InvalidParams s)

let of_yojson json =
  match json % "method" with
  | Some (`String "initialized") -> Ok NInitialized
  | Some (`String "exit") -> Ok NExit
  | Some (`String "textDocument/didOpen") ->
    (
    match json % "params" with
    | None -> Error (ErrorCodes.InvalidParams "Cannot invoke textDocument/didOpen without params")
    | Some params ->  DidOpenParams.of_yojson params |+> (fun x -> Ok (NDidOpen x)) 
    )
  | Some j when (is_s j) -> Error (ErrorCodes.MethodNotFound "Not implemented yet")
  | _ -> Error (ErrorCodes.InvalidRequest "Method is incorrect")