(**  This module handles error code that exist in JSON RPC or that are specific to
     the Language Server Protocol *)

type error_code =
  | ParseError
  | InvalidRequest
  | MethodNotFound
  | InvalidParams
  | InternalError
  | ServerErrorStart
  | ServerErrorEnd
  | ServerNotInitialized
  | UnknownErrorCode
  | RequestCancelled


(** Takes an error code and gives it integer value according to the protocol *)
val to_int : error_code -> int

(** Gives a standard message for each error code *)
val get_message : error_code -> string