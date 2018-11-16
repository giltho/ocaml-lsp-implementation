(** Contains handler that take raw rpc messages and output something usable *)

(** Reads a message and gives a yojson *)
val read_message : log:(string -> unit) -> in_channel -> YojsonShort.json Result.t

(**  Takes a message received in yojson format and returns an actual message*)
(* val json_to_in_message : log:(string -> unit) -> Yojson.json -> InMessage.t *)
