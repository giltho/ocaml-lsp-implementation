open YojsonShort
open Result

type t =
  | IMRequest of RequestMessage.t
  | IMNotification of NotificationMessage.t

let of_yojson json =
  let jsonrpc = json % "jsonrpc" in
  match jsonrpc with
  | Some (`String "2.0") ->
    (match json % "id" with
    | None -> NotificationMessage.of_yojson json
    | Some id -> (RequestMessage.of_yojson json) ||> (fun r -> Ok (IMRequest r))
    )
  | _ -> Error (ErrorCodes.InvalidRequest "jsonrpc field is not set on request")

let to_yojson im =
  match im with
  | IMRequest rm -> RequestMessage.to_yojson rm
  | IMNotification nm -> `String "CANNOT HAVE NOTIFICATIONS YET"