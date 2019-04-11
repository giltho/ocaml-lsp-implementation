(** Defines a notification message *)

(** Defines what a notification message is *)
type t =
  | NExit
      (** @see
          <https://microsoft.github.io/language-server-protocol/specification#exit>
           *)
  | NInitialized
      (** @see
          <https://microsoft.github.io/language-server-protocol/specification#initialized>
           *)
  | NDidOpen of DidOpenTextDocumentParams.t
      (** @see
          <https://microsoft.github.io/language-server-protocol/specification#textDocument_didOpen>
           *)
  | NDidClose of DidCloseTextDocumentParams.t
      (** @see
          <https://microsoft.github.io/language-server-protocol/specification#textDocument_didOpen>
           *)
  | NDidChange of DidChangeTextDocumentParams.t
      (** @see
          <https://microsoft.github.io/language-server-protocol/specification#textDocument_didChange>
           *)
  | NPublishDiagnostics of PublishDiagnosticsParams.t
      (** @see
          <https://microsoft.github.io/language-server-protocol/specification#textDocument_publishDiagnostics>
           *)

val to_yojson : t -> Json.json

val of_yojson : Json.json -> (t, ErrorCodes.t) result
