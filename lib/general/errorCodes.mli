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

val to_int : error_code -> int

val get_message : error_code -> string