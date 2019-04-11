(** This file contains shortcuts to build JSON representations *)
type json = Yojson.Safe.json

val s : string -> Yojson.Safe.json

val o : (string * json) list -> Yojson.Safe.json

val i : int -> Yojson.Safe.json

val b : bool -> Yojson.Safe.json

val f : float -> Yojson.Safe.json

val l : json list -> Yojson.Safe.json

val ( % ) : json -> string -> Yojson.Safe.json option

val parse :
  ?buf:Bi_outbuf.t -> ?fname:string -> ?lnum:int -> string -> Yojson.Safe.json

val json_to_string :
  ?buf:Bi_outbuf.t -> ?len:int -> ?std:bool -> Yojson.Safe.json -> string

val is_s : Yojson.Safe.json -> bool
