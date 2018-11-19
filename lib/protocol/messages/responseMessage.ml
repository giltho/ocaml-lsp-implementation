open YojsonShort

type success =
  | SInitialize of Initialize.Results.t


type data =
  | ResSuccess of success
  | ResError of ErrorCodes.t

type t = {
  resId: json;
  resData: data;
}

let of_yojson =
  function _ -> Error (ErrorCodes.MethodNotFound "Not implemented yet")

let to_yojson { resId; resData } =
  let idj = ("id", resId) in
  match resData with
  | ResSuccess succ ->
    ( 
      let result = 
        match succ with
        | SInitialize ir -> Initialize.Results.to_yojson ir
      in
      o [
        idj;
        ("result", result)
      ]
    )
  | ResError err ->
    let error = ErrorCodes.to_yojson err in
    o [
      idj;
      ("error", error)
    ]