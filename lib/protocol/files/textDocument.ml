module Identifier = struct
  type t = {uri: CUri.t} [@@deriving yojson]
end

module VersionedIdentifier = struct
  type t = {uri: CUri.t; version: int} [@@deriving yojson]
end

module ContentChangeEvent = struct
  type t =
    { range: (Range.t option[@default None])
          (** The range of the document that changed. *)
    ; rangeLength: (int option[@default None])
          (** The length of the range that got replaced. *)
    ; text: string  (** The new text of the range/textDocument *) }
  [@@deriving yojson]
end

module Item = struct
  type t = {uri: CUri.t; languageId: string; version: int; text: string}
  [@@deriving yojson]

  let set_version item version = {item with version}

  let set_text item text = {item with text}

  let update_text item _range _rangeLength _text = item

  let perform_change item change =
    let ContentChangeEvent.{range; rangeLength; text} = change in
    match (range, rangeLength) with
    | Some r, Some rl ->
        update_text item r rl text
    | _, _ ->
        set_text item text
end

module Manager = struct
  type t = (CUri.t, Item.t) Hashtbl.t

  let current : t = Hashtbl.create 10

  let find_opt_uri = Hashtbl.find_opt current

  let find_opt_id tid = find_opt_uri tid.Identifier.uri

  let find_opt_vid vid = find_opt_uri vid.VersionedIdentifier.uri

  let open_item doc = Hashtbl.replace current doc.Item.uri doc

  let close = Hashtbl.remove current

  let close_id tid = close tid.Identifier.uri

  let perform_changes vid changes =
    let VersionedIdentifier.{uri; version} = vid in
    match find_opt_uri uri with
    | Some doc ->
        let modified = List.fold_left Item.perform_change doc changes in
        let updated = Item.set_version modified version in
        let () = Hashtbl.replace current uri updated in
        Some updated
    | None ->
        None
end
