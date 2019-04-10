type kind = TDSKIncremental | TDSKFull | TDSKNone

let kind_of_yojson = function
  | `Int 0 | `Float 0. ->
      Ok TDSKNone
  | `Int 1 | `Float 1. ->
      Ok TDSKFull
  | `Int 2 | `Float 2. ->
      Ok TDSKIncremental
  | j ->
      Error (Yojson.Safe.to_string j ^ " is not a correct TextDocumentSyncKind")

let kind_to_yojson = function
  | TDSKNone ->
      `Int 0
  | TDSKFull ->
      `Int 1
  | TDSKIncremental ->
      `Int 2

type saveOptions = {includeText: (bool[@default false])} [@@deriving yojson]

let implementedSaveOptions = {includeText= false}

type t =
  { openClose: bool
  ; change: kind
  ; willSave: bool
  ; willSaveWaitUntil: bool
  ; save: saveOptions }
[@@deriving yojson]

let implemented =
  { openClose= true
  ; change= TDSKFull
  ; willSave= false
  ; willSaveWaitUntil= false
  ; save= implementedSaveOptions }
