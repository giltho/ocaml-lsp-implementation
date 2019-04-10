(** Some functions for the option type of OCaml *)

exception No_value
(** Raised when calling [get None]. *)

val get : 'a option -> 'a
(** [get (Some x)] returns [x] and [get None] raises [No_value] *)