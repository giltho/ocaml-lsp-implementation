module type S = sig
  val diagnose : DocumentUri.t -> Diagnostic.t list -> unit
end

include S
