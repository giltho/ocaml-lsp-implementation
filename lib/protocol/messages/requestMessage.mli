(** Possible methods for requests *)
type rMethod =
  (** method 'initialize' that comes with 'Initialize.Params' *)
  | RInitialize of Initialize.Params.t

(** Representation of a request message *)
type t = {

  (** The id is kept in json form, because we don't really care about its value *)
  rId: YojsonShort.json;

  (** This field contains the method with the params *)
  rMethod: rMethod;
}

val of_yojson : YojsonShort.json -> t Result.t

val to_yojson : t -> YojsonShort.json