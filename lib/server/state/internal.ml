let _log_channel = ref Lwt_io.stdout

let get_log_channel () = !_log_channel

let set_log_channel channel = _log_channel := channel

let client_channel = Lwt_io.stdout