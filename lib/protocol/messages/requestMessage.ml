open Json

type rMethod = RInitialize of InitializeParams.t

(** This is used to propagate invalid params from yojson parsing *)
let ( |+> ) result f =
  match result with
  | Ok x -> f x
  | Error s -> Error (ErrorCodes.InvalidParams s)

type t = { rId : json; rMethod : rMethod }

(** Should only be called if it is sure that there is an `id` in the message *)
let of_yojson json =
  let rId = Option.get (json % "id") in
  match json % "method" with
  | Some (`String "initialize") -> (
      let params = json % "params" in
      match params with
      | Some p ->
          InitializeParams.of_yojson p |+> fun x ->
          Ok { rId; rMethod = RInitialize x }
      | None ->
          Error
            (ErrorCodes.InvalidParams
               "Cannot invoke initialize without parameters") )
  | Some j when is_s j ->
      Error (ErrorCodes.MethodNotFound "Not implemented yet")
  | _ -> Error (ErrorCodes.InvalidRequest "Method is incorrect")

let to_yojson { rId; rMethod } =
  match rMethod with
  (* method 'initialize' *)
  | RInitialize p ->
      `Assoc
        [ ("id", rId);
          ("method", `String "initialize");
          ("params", InitializeParams.to_yojson p)
        ]
