(** This file contains shortcuts to build JSON representations *)
type t = Yojson.Safe.json

let s = fun s -> `String s

let o = fun l -> `Assoc l

let i = fun n -> `Int n

let b = fun tf -> `Bool tf

let f = fun n -> `Float n

let l = fun jl -> `List jl

let ( % ) json field =
  let rec find_field l =
    match l with
    | [] -> None
    | (k, v) :: _ when field = k -> Some v
    | _ :: r -> find_field r
  in
  match json with `Assoc l -> find_field l | _ -> None

let parse = Yojson.Safe.from_string

let json_to_string = Yojson.Safe.to_string

let is_s = function `String _ -> true | _ -> false