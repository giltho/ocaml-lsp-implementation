type t = {
  processId : (int option [@default None]);
  rootUri : (CUri.t [@default Uri.empty]);
  capabilities : (ClientCapabilities.t [@default ClientCapabilities.default]);
  (* TODO: workspaceFolders : workspaceFolders.t; *)
  trace : Trace.t [@default Trace.TOff];
}[@@deriving yojson { strict = false }]