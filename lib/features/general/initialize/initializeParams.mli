(** This file is used for the handling of the 'initialize' method of the protocol *)

(** Parameters for the method *)
type t = {

  (** The process Id of the parent process that started
	    the server. Is null if the process has not been started by another process.
	    If the parent process is not alive then the server should exit
      (see {!Lsp__Exit} notification) its process. *)
  processId : (int option [@default None]);

  (** The rootUri of the workspace. Is null if no
	    folder is open. If both `rootPath` and `rootUri` are set
	   `rootUri` wins. *)
  rootUri : CUri.t;

  (** The capabilities provided by the client (editor or tool) *)
  capabilities : (ClientCapabilities.t [@default ClientCapabilities.default]);
  (* TODO: workspaceFolders : workspaceFolders.t; *)

  (** The initial trace setting. If omitted trace is disabled ('off'). *)
  trace : Trace.t [@default Trace.TOff];
}[@@deriving yojson { strict = false }]