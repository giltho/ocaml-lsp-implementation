type t = {resolveProvider: bool; triggerCharacters: string list}
[@@deriving yojson]

let implemented = {resolveProvider= false; triggerCharacters= []}
