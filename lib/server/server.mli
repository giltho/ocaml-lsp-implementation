(** The LSP module contains the functor {!Make} that builds a language server
    from a parameter module with signature [P] *)

(** This module type defines the signature of parameters that should be given
    to the {!Make} functor in order to build a Language Server *)


module type P = sig
end

(** This functor builds a Language Server from a parameter module of signature
    {!P} *)
module Make (P : P) : sig
  val start : unit -> unit
  (** Executing start will launch the language server. It uses
      {!Lsp__Rpc.read_message} to read the the messages from {!P.inc} *)
end
