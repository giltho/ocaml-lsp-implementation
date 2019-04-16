open Protocol

type t = (DocumentUri.t, TextDocumentItem.t) Hashtbl.t

let current : t = Hashtbl.create 10

let find_opt_uri = Hashtbl.find_opt current

let find_opt_id tid = find_opt_uri tid.TextDocumentIdentifier.uri

let find_opt_vid vid = find_opt_uri vid.VersionedTextDocumentIdentifier.uri

let open_item doc = Hashtbl.replace current doc.TextDocumentItem.uri doc

let close = Hashtbl.remove current

let close_id tid = close tid.TextDocumentIdentifier.uri

(* The Following functions are used to modify a text document objects *)
let update_text item range rangeLength text =
  failwith
    "Update_text is not implemented yet, and the client should not be \
     configured for incremental update"

let set_text item text = TextDocumentItem.{ item with text }

let perform_one_change item change =
  let TextDocumentContentChangeEvent.{ range; rangeLength; text } = change in
  match (range, rangeLength) with
  | Some r, Some rl -> update_text item r rl text
  | _, _ -> set_text item text

let set_version item version = TextDocumentItem.{ item with version }

let perform_changes vid changes =
  let VersionedTextDocumentIdentifier.{ uri; version } = vid in
  match version with
  | Some ver -> (
    match find_opt_uri uri with
    | Some doc ->
        let modified = List.fold_left perform_one_change doc changes in
        let updated = set_version modified ver in
        let () = Hashtbl.replace current uri updated in
        Ok updated
    | None ->
        Error
          (ErrorCodes.InvalidRequest
             "Modifiying a document that was never opened.") )
  | None ->
      Error
        (ErrorCodes.InvalidParams
           "Version cannot be null when sent by the client.")
