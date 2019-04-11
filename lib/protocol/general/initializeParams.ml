(** This module is used for params of the 'initialize' method of the protocol *)

(** Parameters for the method *)
type t = {
  processId : (int option[@default None]);
      (** The process Id of the parent process that started the server. Is null
          if the process has not been started by another process. If the parent
          process is not alive then the server should exit (see {!Lsp__Exit}
          notification) its process. *)
  rootUri : DocumentUri.t;
      (** The rootUri of the workspace. Is null if no folder is open. If both
          `rootPath` and `rootUri` are set `rootUri` wins. *)
  capabilities : (ClientCapabilities.t[@default ClientCapabilities.default]);
      (** The capabilities provided by the client (editor or tool) *)
  trace : Trace.t [@default Trace.TOff]
      (** The initial trace setting. If omitted trace is disabled ('off'). *)
  (* TODO: workspaceFolders : workspaceFolders.t; *)
}
[@@deriving yojson { strict = false }]