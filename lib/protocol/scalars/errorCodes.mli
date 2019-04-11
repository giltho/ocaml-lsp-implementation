(** This module handles error code that exist in JSON RPC or that are specific
    to the Language Server Protocol *)

type t =
  | ParseError of string
  | InvalidRequest of string
  | MethodNotFound of string
  | InvalidParams of string
  | InternalError of string
  | ServerErrorStart of string
  | ServerErrorEnd of string
  | ServerNotInitialized of string
  | UnknownErrorCode of string
  | RequestCancelled of string

val to_yojson : t -> Json.json
(** Returns the ResponseError associated to the code *)
