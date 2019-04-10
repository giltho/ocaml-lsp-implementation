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
  | NDidOpen of DidOpen.Params.t
      (** @see
          <https://microsoft.github.io/language-server-protocol/specification#textDocument_didOpen>
           *)
  | NDidClose of DidClose.Params.t
      (** @see
          <https://microsoft.github.io/language-server-protocol/specification#textDocument_didOpen>
           *)
  | NDidChange of DidChange.Params.t
      (** @see
          <https://microsoft.github.io/language-server-protocol/specification#textDocument_didChange>
           *)
  | NPublishDiagnostics of PublishDiagnostics.Params.t
      (** @see
          <https://microsoft.github.io/language-server-protocol/specification#textDocument_publishDiagnostics>
           *)

val to_yojson : t -> YojsonShort.json

val of_yojson : YojsonShort.json -> t Result.t
