
(** Contains handler that take raw rpc messages and output something usable *)

(** Reads a message and gives a yojson *)
val read_message : log:(string -> unit) -> in_channel -> YojsonShort.json

