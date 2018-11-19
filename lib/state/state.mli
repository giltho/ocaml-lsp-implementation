(** The State module contains informations about the state of the language server.
    In particular, it should be initialized with the first request *)

(** describes the current state of the server *)
type t = {

  (** The rootUri of the workspace. Is empty if no folder is open *)
  rootUri: Uri.t;

  (** The capabilities provided by the client (editor or tool) *)
  clientCapabilities: ClientCapabilities.t;

  (** Level of debugging that should be given by the server *)
  trace: Trace.t;

  (** The process Id of the parent process that started
	    the server. Is None if the process has not been started by another process.
	    If the parent process is not alive then the server
      should exit (see {!Exit}) its process. *)
  parentProcessId: int option;
}

(** Function that should be called to initialize the server *)
val initialize : int option -> Uri.t -> ClientCapabilities.t -> Trace.t -> unit

(** Returns true if the initialize request has been received, false otherwise *)
val initialized : unit -> bool

(** Returns the current state of the server *)
val get : unit -> t