open General_types

type initialize_params = {
  process_id : int option;
  root_uri : Uri.t;
  capabilities : client_capabilities;
  workspace_folders : workspace_folders option;
  trace : trace;
}