(** This file contains shortcuts to build JSON representations *)
type t = Yojson.Safe.json

val s : string -> t

val o : (string * t) list -> t

val i : int -> t

val b : bool -> t

val f : float -> t

val l : t list -> t

val ( % ) : t -> string -> t option

val parse : ?buf:Bi_outbuf.t -> ?fname:string -> ?lnum:int -> string -> t

val json_to_string :
  ?buf:Bi_outbuf.t -> ?len:int -> ?std:bool -> t -> string

val is_s : t -> bool
