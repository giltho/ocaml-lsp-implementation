type t = Uri.t

val of_yojson : Json.t -> (t, string) result

val to_yojson : t -> Json.t
