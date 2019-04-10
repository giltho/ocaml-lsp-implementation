(** Some functions for the option type of OCaml *)

(** Raised when calling [get None]. *)
exception No_value

val get : 'a option -> 'a
(** [get (Some x)] returns [x] and [get None] raises [No_value] *)
