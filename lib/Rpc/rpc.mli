(** Contains handler that take raw rpc messages and output something usable *)

(** Reads a message and gives a yojson *)
val read_yojson : unit -> YojsonShort.json Result.t

(**  Sens a yojson to the client *)
val write_yojson : YojsonShort.json -> unit
