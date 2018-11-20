type t =
  (** Exit corresponds to terminating the server, and returning the value r *)
  | Exit
  (** Respond corresponds to sending the response message given *)
  | Respond of ResponseMessage.t


val execute : t -> unit

val execute_all : t list -> unit