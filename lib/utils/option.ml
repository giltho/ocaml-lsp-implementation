(** Some functions for the option type of OCaml *)

(** Raised when calling [get None]. *)
exception No_value

let get = function Some a -> a | None -> raise No_value
