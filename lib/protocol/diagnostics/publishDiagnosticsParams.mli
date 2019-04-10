  type t = {
    uri : CUri.t;  (** The URI for which diagnostic information is reported*)
    diagnostics : Diagnostic.t list
        (** The capabilities provided by the client (editor or tool) *)
  }
  [@@deriving yojson { strict = false }]