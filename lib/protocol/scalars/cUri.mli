type t = Uri.t

val of_yojson : YojsonShort.json -> (t, string) result

val to_yojson : t -> YojsonShort.json
