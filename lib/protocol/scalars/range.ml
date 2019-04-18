type t = {
  start : Position.t [@key "start"]; (** The range's start position.*)
  end_ : Position.t [@key "end"]; (** The range's end position. *)
  }
[@@deriving yojson]
