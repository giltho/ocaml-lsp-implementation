module type S = sig
  val diagnose : CUri.t -> Diagnostic.t list -> unit
end

include S