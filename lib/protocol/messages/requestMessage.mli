(** Possible methods for requests *)
type rMethod =
  | RInitialize of Initialize.Params.t
      (** method 'initialize' that comes with 'Initialize.Params' *)

(** Representation of a request message *)
type t = {
  rId : YojsonShort.json;
      (** The id is kept in json form, because we don't really care about its
          value *)
  rMethod : rMethod  (** This field contains the method with the params *)
}

val of_yojson : YojsonShort.json -> t Result.t

val to_yojson : t -> YojsonShort.json
