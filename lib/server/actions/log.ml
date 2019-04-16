let log s = Lwt_io.write (State.Internal.get_log_channel ()) (s ^ "\n")

let log_json j = log (Utils.Json.json_to_string j)

let log_error ec = log_json (Protocol.ErrorCodes.to_yojson ec)

let log_result ~to_json r =
  match r with Ok a -> log_json (to_json a) | Error ec -> log_error ec
