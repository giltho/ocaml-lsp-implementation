type t = {
  uri : DocumentUri.t;  (** The text document's URI. *)
  languageId : string;  (** The text document's language identifier. *)
  version : int;
      (** The version number of this document (it will increase after each
          change, including undo/redo). *)
  text : string  (** The content of the opened text document. *)
}
[@@deriving yojson]
