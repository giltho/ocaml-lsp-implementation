module Identifier = struct
  type t = { uri : DocumentUri.t } [@@deriving yojson]
end

module VersionedIdentifier = struct
  type t = { uri : DocumentUri.t; version : int } [@@deriving yojson]
end

module ContentChangeEvent = struct
  type t = {
    range : (Range.t option[@default None]);
        (** The range of the document that changed. *)
    rangeLength : (int option[@default None]);
        (** The length of the range that got replaced. *)
    text : string  (** The new text of the range/textDocument *)
  }
  [@@deriving yojson]
end

module Item = struct
  type t = {
    uri : DocumentUri.t;
    languageId : string;
    version : int;
    text : string
  }
  [@@deriving yojson]

  let set_version item version = { item with version }

  let set_text item text = { item with text }

  let update_text item _range _rangeLength _text = item

  let perform_change item change =
    let ContentChangeEvent.{ range; rangeLength; text } = change in
    match (range, rangeLength) with
    | Some r, Some rl -> update_text item r rl text
    | _, _ -> set_text item text
end
