(** Defines a notification message *)

(** Defines what a notification message is *)
type t =
  | NExit
  (** @see <https://microsoft.github.io/language-server-protocol/specification#exit> *)
  | NInitialized
  (** @see <https://microsoft.github.io/language-server-protocol/specification#initialized> *)
  | NDidOpen of DidOpenParams.t
  (** @see  <https://microsoft.github.io/language-server-protocol/specification#textDocument_didOpen> *)


val to_yojson : t -> YojsonShort.json

val of_yojson : YojsonShort.json -> t Result.t