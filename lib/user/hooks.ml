module type S = sig
  (** This module type defines hooks that should be defined
      by the user to give a user-defined behavior to the server *)

  val onDidChangeContent : TextDocument.Item.t -> unit
end
