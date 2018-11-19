(** Defines a notification message *)

(** Defines what a notification message is *)
type t =
  (** The notification that  *)
  | NExit
  | NInitialized

val to_yojson : t -> YojsonShort.json

val of_yojson : YojsonShort.json -> t Result.t