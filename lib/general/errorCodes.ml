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

let to_int = function
  | ParseError -> -32700
  | InvalidRequest -> -32600
  | MethodNotFound -> -32601
  | InvalidParams -> -32602
  | InternalError -> -32603
  | ServerErrorStart -> -32099
  | ServerErrorEnd -> -32000
  | ServerNotInitialized -> -32002
  | UnknownErrorCode -> -32001
  | RequestCancelled -> -32800

let get_message = function
  | _ -> "an error has occured"