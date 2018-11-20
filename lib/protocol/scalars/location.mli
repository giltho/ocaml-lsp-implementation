(** Represents a location inside a resource, such as a line inside a text file. *)

type t = {
  uri: CUri.t;
  range: Range.t;
}[@@deriving yojson]