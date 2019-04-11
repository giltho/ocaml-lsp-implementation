(** This type describes severity *)
type t = SevError | SevWarning | SevInfo | SevHint [@@deriving yojson]
