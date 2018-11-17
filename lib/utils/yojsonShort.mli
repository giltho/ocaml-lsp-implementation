(** This file contains shortcuts to build JSON representations *)
type json = Yojson.Safe.json

val s : string -> json
val o : (string * json) list -> json
val i : int -> json
val b : bool -> json
val f : float -> json
val l : json list -> json

val (%) : json -> string -> json option

val parse : ?buf:Bi_outbuf.t -> ?fname:string -> ?lnum:int -> string -> json

val is_s : json -> bool