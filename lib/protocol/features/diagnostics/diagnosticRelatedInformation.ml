(** Related information should have a type that can be serialized and
    deserialized from yojson *)
type t = {
  location : Location.t;
      (** The location of this related diagnostic information. *)
  message : string  (** The message of this related diagnostic information. *)
}
[@@deriving yojson]
