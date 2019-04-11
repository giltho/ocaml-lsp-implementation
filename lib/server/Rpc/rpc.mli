(** Contains handler that take raw rpc messages and output something usable *)

val read_yojson : unit -> Json.json Result.t
(** Reads a message and gives a yojson *)

val write_yojson : Json.json -> unit
(** Sens a yojson to the client *)
