(** Contains handler that take raw rpc messages and output something usable *)

val read_yojson : unit -> YojsonShort.json Result.t
(** Reads a message and gives a yojson *)

val write_yojson : YojsonShort.json -> unit
(**  Sens a yojson to the client *)
