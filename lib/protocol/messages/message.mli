(** This module describes received messages and how to parse them *)

(** Type of received messages, it can be either a request, a notification or a
    response to a prevously sent request *)
type t =
  | MRequest of RequestMessage.t
  | MNotification of NotificationMessage.t
  | MResponse of ResponseMessage.t

val of_yojson : Json.json -> (t, ErrorCodes.t) Result.t
(** Parses a received message in yojson form to an actual Message *)

val to_yojson : t -> Json.json
