(** This module defines textDocumentClientCapabilities.
    They are on of the component of {!Lsp__.ClientCapabilities}
    They are composed of several elements that we define and use in this module *)


(**  Synchronisation Capabilities register capabilities related to the synchronisation
     of text documents between the server and the client. *)
type synchronisationCapabilities = {

  dynamicRegistration: bool; (** Whether text document synchronization
                                 supports dynamic registration. *)
  willSave:            bool; (** The client supports sending will save
                                 notifications. *)

  willSaveWaitUntil:   bool; (** The client supports sending a will save
                                 request and waits for a response providing
                                 text edits which will be applied to the
                                 document before it is saved. *)

  didSave:             bool; (** The client supports did save notifications. *)
}

(** This type define textDocumentClientCapabilities *)
type t = {
  synchronisation: (synchronisationCapabilities [@default defaultSynchronisation]); (**
    the synchronisation field contains capabilities related to the *)
} [@@deriving yojson]