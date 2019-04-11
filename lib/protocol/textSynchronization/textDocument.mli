(** This module describes utils that allow to manipulate text documents *)

(** The module identifier contains the TextDocument.Identifier type *)
module Identifier : sig
  type t = { uri : DocumentUri.t  (** The text document's URI *) } [@@deriving yojson]
end

module VersionedIdentifier : sig
  (** An identifier to denote a specific version of a text document. *)
  type t = {
    uri : DocumentUri.t;  (** DocumentUri of the document *)
    version : int
        (* option *)
        (** The version number of this document. If a versioned text document
            identifier is sent from the server to the client and the file is
            not open in the editor (the server has not received an open
            notification before) the server can send `null` to indicate that
            the version is known and the content on disk is the truth (as
            speced with document content ownership). The version number of a
            document will increase after each change, including undo/redo. The
            number doesn't need to be consecutive. *)
  }
  [@@deriving yojson]
end

module Item : sig
  (** An item to transfer a text document from the client to the server. *)
  type t = {
    uri : DocumentUri.t;  (** The text document's URI. *)
    languageId : string;  (** The text document's language identifier. *)
    version : int;
        (** The version number of this document (it will increase after each
            change, including undo/redo). *)
    text : string  (** The content of the opened text document. *)
  }
  [@@deriving yojson]
end

module ContentChangeEvent : sig
  type t = {
    range : Range.t option;  (** The range of the document that changed. *)
    rangeLength : int option;
        (** The length of the range that got replaced. *)
    text : string  (** The new text of the range/textDocument *)
  }
  [@@deriving yojson]
end
