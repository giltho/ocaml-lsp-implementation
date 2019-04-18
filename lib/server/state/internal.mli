(** Contains internal configuration *)

val get_log_channel : unit -> Lwt_io.output Lwt_io.channel

val set_log_channel : Lwt_io.output Lwt_io.channel -> unit

val client_channel : Lwt_io.output Lwt_io.channel
