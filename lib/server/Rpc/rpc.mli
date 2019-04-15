(** Contains handler that take raw rpc messages and output something usable *)

val read_yojson : unit -> ((Json.json, string) result) Lwt.t
(** Reads a message and gives a yojson *)

val write_yojson : Json.json -> unit Lwt.t
(** Sends a yojson to the client *)
