(** This file contains the function that handles a received message *)

val handle : Message.t Result.t -> Action.t list