type t = {
	rstart: Position.t; [@key "start"]
	rend: Position.t; [@key "end"]
}[@@deriving yojson]