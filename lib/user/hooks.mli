module type S = sig
  (** This module type defines hooks that should be defined by the user to give
      a user-defined behavior to the server *)

  val onDidChangeContent : TextDocument.Item.t -> unit
  (** [onDidChangeContent textDoc] allows the user to do things when the
      document [textDoc] is updated. The user will usually make use of the
      actions offered by the {!Actions} module. *)
end
