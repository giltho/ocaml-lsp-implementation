(** This module defines textDocumentClientCapabilities. They are on of the
    component of {!Lsp__.ClientCapabilities} They are composed of several
    elements that we define and use in this module *)

(** This type define textDocumentClientCapabilities *)
type t [@@deriving yojson]

val default : t
