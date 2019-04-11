module Params = struct
  (** This module is used for params of the 'textDocument/PublishDiagnostics'
      method of the protocol *)

  (** Parameters for the method *)
  type t = {
    uri : DocumentUri.t;
        (** The URI for which diagnostic information is reported*)
    diagnostics : Diagnostic.t list
        (** The capabilities provided by the client (editor or tool) *)
  }
  [@@deriving yojson { strict = false }]
end
