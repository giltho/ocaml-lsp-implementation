open Json

module Data = struct
  module Success = struct
    type t =
      | SInitialize of InitializeResult.t
  end

  type t =
    | ResSuccess of Success.t
    | ResError of ErrorCodes.t
end

type t = { id : json; data : Data.t }

let of_yojson = function
  | _ -> Error (ErrorCodes.MethodNotFound "Not implemented yet")

let to_yojson { id; data } =
  let idj = ("id", id) in
  match data with
  | ResSuccess succ ->
      let result =
        match succ with SInitialize ir -> InitializeResult.to_yojson ir
      in
      o [ idj; ("result", result) ]
  | ResError err ->
      let error = ErrorCodes.to_yojson err in
      o [ idj; ("error", error) ]
