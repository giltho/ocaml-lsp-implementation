type initialize_params = {
  process_id : int option;
  root_uri : Uri.t;
  capabilities : ClientCapabilities.t;
  workspace_folders : unit;
  trace : unit;
}