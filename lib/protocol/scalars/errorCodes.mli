(**  This module handles error code that exist in JSON RPC or that are specific to
     the Language Server Protocol *)

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


(** Takes an error code and gives it integer value according to the protocol *)
val to_int : t -> int

(** Gives a standard message for each error code *)
val to_string : t -> string