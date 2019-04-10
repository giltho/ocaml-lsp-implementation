(** Some functions for the option type of OCaml *)

exception No_value
(** Raised when calling [get None]. *)

let get = function Some a -> a | None -> raise No_value