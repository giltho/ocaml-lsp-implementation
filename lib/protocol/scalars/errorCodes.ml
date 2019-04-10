open YojsonShort

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

let code_and_message =
  let p = Printf.sprintf "%s: %s" in
  function
  | ParseError s -> (-32700, p "ParseError" s)
  | InvalidRequest s -> (-32600, p "InvalidRequest" s)
  | MethodNotFound s -> (-32601, p "MethodNotFound" s)
  | InvalidParams s -> (-32602, p "InvalidParams" s)
  | InternalError s -> (-32603, p "InternalError" s)
  | ServerErrorStart s -> (-32099, p "ServerErrorStart" s)
  | ServerErrorEnd s -> (-32000, p "ServerErrorEnd" s)
  | ServerNotInitialized s -> (-32002, p "ServerNotInitialized" s)
  | UnknownErrorCode s -> (-32001, p "UnknownErrorCode" s)
  | RequestCancelled s -> (-32800, p "RequestCancelled" s)

let to_yojson e =
  let code, message = code_and_message e in
  o [ ("code", i code); ("message", s message) ]
