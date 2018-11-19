open YojsonShort

(* Since there's no id the type is directly method + params *)
type t =
  | NExit
  | NInitialized 



let to_yojson =
  function
    | NExit -> o([
      ("method", s("exit"));
    ])
    | NInitialized -> o([
      ("method", s("initialized"))
    ])

let of_yojson json =
  match json % "method" with
  | Some (`String "initialized") -> Ok NInitialized
  | Some (`String "exit") -> Ok NExit
  | Some j when (is_s j) -> Error (ErrorCodes.MethodNotFound "Not implemented yet")
  | _ -> Error (ErrorCodes.InvalidRequest "Method is incorrect")