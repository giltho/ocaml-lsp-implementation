(** This file contains shortcuts to build JSON representations *)
type json = Yojson.Safe.json

let s : string -> json = fun s -> `String s
let o : (string * json) list -> json = fun l -> `Assoc l
let i : int -> json = fun n -> `Int n
let b : bool -> json = fun tf -> `Bool tf
let f : float -> json = fun n -> `Float n
let l : json list -> json = fun jl -> `List jl


let parse = Yojson.Safe.from_string