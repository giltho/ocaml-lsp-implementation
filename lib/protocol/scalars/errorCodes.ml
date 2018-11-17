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

let to_int = function
  | ParseError _ -> -32700
  | InvalidRequest _ -> -32600
  | MethodNotFound _ -> -32601
  | InvalidParams _ -> -32602
  | InternalError _ -> -32603
  | ServerErrorStart _ -> -32099
  | ServerErrorEnd _ -> -32000
  | ServerNotInitialized _ -> -32002
  | UnknownErrorCode _ -> -32001
  | RequestCancelled _ -> -32800

let to_string = 
  let p = Printf.sprintf "%s: %s" in
  function
  | ParseError s -> p "ParseError" s
  | InvalidRequest s -> p "InvalidRequest" s
  | MethodNotFound s -> p "MethodNotFound" s
  | InvalidParams s -> p "InvalidParams" s
  | InternalError s -> p "InternalError" s
  | ServerErrorStart s -> p "ServerErrorStart" s
  | ServerErrorEnd s -> p "ServerErrorEnd" s
  | ServerNotInitialized s -> p "ServerNotInitialized" s
  | UnknownErrorCode s -> p "UnknownErrorCode" s
  | RequestCancelled s -> p "RequestCancelled" s