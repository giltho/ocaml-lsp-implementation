let return a = Ok a
let map a ~f =
  match a with
  | Ok o -> Ok (f o)
  | Error _ as e -> e

let both a b =
  match a with
  | Ok aa -> (
    match b with
    | Ok bb -> Ok (aa,bb)
    | Error bb -> Error bb
  )
  | Error aa -> Error aa