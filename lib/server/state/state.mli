(** The State module contains informations about the state of the language
    server. In particular, it should be initialized with the first request *)

(** describes the current state of the server *)
type t = {
  rootUri : DocumentUri.t;
      (** The rootUri of the workspace. Is empty if no folder is open *)
  clientCapabilities : ClientCapabilities.t;
      (** The capabilities provided by the client (editor or tool) *)
  trace : Trace.t;
      (** Level of debugging that should be given by the server *)
  parentProcessId : int option
      (** The process Id of the parent process that started the server. Is None
          if the process has not been started by another process. If the parent
          process is not alive then the server should exit (see {!Exit}) its
          process. *)
}

val initialize : int option -> DocumentUri.t -> ClientCapabilities.t -> Trace.t -> unit
(** Function that should be called to initialize the server *)

val initialized : unit -> bool
(** Returns true if the initialize request has been received, false otherwise *)

val get : unit -> t
(** Returns the current state of the server *)
