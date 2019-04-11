type t

val empty : t

val of_yojson : Json.json -> (t, string) result

val to_yojson : t -> Json.json