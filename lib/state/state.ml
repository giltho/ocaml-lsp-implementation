let current_uri = ref Uri.empty

let set_current_uri nuri = current_uri := nuri

let get_current_uri () = !current_uri

let is_initialized = ref false

let initialize _process_id uri _capabililities =
  let () = set_current_uri uri in
  let () = is_initialized := true in
  ()

let initialized () = !is_initialized