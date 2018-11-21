module Severity : sig

  type t =
    | SevError
    | SevWarning
    | SevInfo
    | SevHint
  [@@deriving yojson]
  (** This type describes severity *)

end

module RelatedInformation : sig
  (** Related information should have a type that can be serialized and deserialized from yojson *)
  type t = {
    location: Location.t;
    (** The location of this related diagnostic information. *)
    message: string;
    (** The message of this related diagnostic information. *)
  }[@@deriving yojson]
end
(** *)
type t = {
  range: Range.t;
  (**
     	 The range at which the message applies.
     	 *)
  severity: Severity.t option;
  (**
     	 The diagnostic's severity. Can be omitted. If omitted it is up to the
     	 client to interpret diagnostics as error, warning, info or hint.
     	 *)

  code: string option;
  (**
     	 The diagnostic's code, which might appear in the user interface.
     	 *)
  source: string;
  (**
     	 A human-readable string describing the source of this
     	 diagnostic, e.g. 'typescript' or 'super lint'.
     	 *)
  message: string;
  (**
     	 The diagnostic's message.
     	 *)
  relatedInformation: RelatedInformation.t;
  (**
     	 An array of related diagnostic information, e.g. when symbol-names within
     	 a scope collide all definitions can be marked via this property.
     	 *)
}[@@deriving yojson]