(** Possible methods for requests *)
type rMethod =
  | RInitialize of InitializeParams.t
      (** method 'initialize' that comes with 'Initialize.Params' *)

(** Representation of a request message *)
type t = {
  rId : Json.json;
      (** The id is kept in json form, because we don't really care about its
          value *)
  rMethod : rMethod  (** This field contains the method with the params *)
}

val of_yojson : Json.json -> (t, ErrorCodes.t) result

val to_yojson : t -> Json.json
