open Json

type m = RInitialize of InitializeParams.t

(** This is used to propagate invalid params from yojson parsing *)
let ( |+> ) result f =
  match result with
  | Ok x -> f x
  | Error s -> Error (ErrorCodes.InvalidParams s)

type t = { id : json; method_ : m }

(** Should only be called if it is sure that there is an `id` in the message *)
let of_yojson (json : Yojson.Safe.json) : (t, ErrorCodes.t) result =
  let id = Option.get (json % "id") in
  match json % "method" with
  | Some (`String "initialize") -> (
      let params = json % "params" in
      match params with
      | Some p ->
          InitializeParams.of_yojson p |+> fun x ->
          Ok { id; method_ = RInitialize x }
      | None ->
          Error
            (ErrorCodes.InvalidParams
               "Cannot invoke initialize without parameters") )
  | Some j when is_s j ->
      Error (ErrorCodes.MethodNotFound "Not implemented yet")
  | _ -> Error (ErrorCodes.InvalidRequest "Method is incorrect")

let to_yojson ({ id; method_ } : t) : Yojson.Safe.json =
  match method_ with
  (* method 'initialize' *)
  | RInitialize p ->
      `Assoc
        [ ("id", id);
          ("method", `String "initialize");
          ("params", InitializeParams.to_yojson p)
        ]
