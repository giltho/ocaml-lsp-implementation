type t = {
	rstart: Position.t;
	(** The range's start position.*)

	rend: Position.t;
  (** The range's end position. *)
}[@@deriving yojson]