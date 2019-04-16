val log : string -> unit Lwt.t

val log_json : Utils.Json.json -> unit Lwt.t

val log_error : Protocol.ErrorCodes.t -> unit Lwt.t

val log_result :
  to_json:('a -> Utils.Json.json) ->
  ('a, Protocol.ErrorCodes.t) result ->
  unit Lwt.t
