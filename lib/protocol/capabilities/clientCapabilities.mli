(**  This module describes Client Capabilities. *)

(** Type defining client capabilities *)
type t [@@deriving yojson]

val default : t
