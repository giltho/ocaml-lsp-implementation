(** This module describes received messages and how to parse them *)

open Json
open Result

(** Type of received messages, it can be either a request, a notification or a
    response to a prevously sent request *)
type t =
  | MRequest of RequestMessage.t
  | MNotification of NotificationMessage.t
  | MResponse of ResponseMessage.t

let of_yojson (json: Yojson.Safe.json) : (t, ErrorCodes.t) result =
  match json % "jsonrpc" with
  | Some (`String "2.0") -> (
    match (json % "id", json % "method") with
    (* No id, some method, it's a notification*)
    | None, Some _ ->
        NotificationMessage.of_yojson json ||> fun r -> Ok (MNotification r)
    (* An id and a method, it's a request *)
    | Some _, Some _ ->
        RequestMessage.of_yojson json ||> fun r -> Ok (MRequest r)
    (* No method but an id, it's a response *)
    | Some _, None ->
        ResponseMessage.of_yojson json ||> fun r -> Ok (MResponse r)
    (* We don't know what it is, that's a mistake *)
    | None, None ->
        Error
          (ErrorCodes.InvalidRequest "Neither id nor method is specified !") )
  | _ ->
      Error (ErrorCodes.InvalidRequest "jsonrpc field is not set on request")

let to_yojson (message: t) : Yojson.Safe.json =
  let without_jsonrpc =
    match message with
    | MRequest rm -> RequestMessage.to_yojson rm
    | MNotification nm -> NotificationMessage.to_yojson nm
    | MResponse rm -> ResponseMessage.to_yojson rm
  in
  let jsonrpc = ("jsonrpc", s "2.0") in
  match without_jsonrpc with
  | `Assoc l -> `Assoc (jsonrpc :: l)
  | _ -> failwith "A message cannot be something other than an object !!!"
