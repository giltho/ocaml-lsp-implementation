type t = {
  range : Range.t;  (** The range at which the message applies. *)
  severity : DiagnosticSeverity.t option;
      (** The diagnostic's severity. Can be omitted. If omitted it is up to the
          client to interpret diagnostics as error, warning, info or hint. *)
  code : string option;
      (** The diagnostic's code, which might appear in the user interface. *)
  source : string;
      (** A human-readable string describing the source of this diagnostic,
          e.g. 'typescript' or 'super lint'. *)
  message : string;  (** The diagnostic's message. *)
  relatedInformation : DiagnosticRelatedInformation.t list
      (** An array of related diagnostic information, e.g. when symbol-names
          within a scope collide all definitions can be marked via this
          property. *)
}
[@@deriving yojson]
