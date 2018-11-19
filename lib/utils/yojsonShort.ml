(** This file contains shortcuts to build JSON representations *)
type json = Yojson.Safe.json

let s : string -> json = fun s -> `String s
let o : (string * json) list -> json = fun l -> `Assoc l
let i : int -> json = fun n -> `Int n
let b : bool -> json = fun tf -> `Bool tf
let f : float -> json = fun n -> `Float n
let l : json list -> json = fun jl -> `List jl

let (%) json field =
  let rec find_field l =
    match l with
    | [] -> None
    | (k, v)::r when field = k -> Some v
    | _::r -> find_field r
  in
  match json with
  | `Assoc l -> find_field l
  | _        -> None

let parse = Yojson.Safe.from_string

let json_to_string = Yojson.Safe.to_string

let is_s = function
  | `String _ -> true
  | _         -> false