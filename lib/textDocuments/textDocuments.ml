
type t = (CUri.t, TextDocumentItem.t) Hashtbl.t

let current : t = Hashtbl.create 10

let find_opt_uri = Hashtbl.find_opt current

let find_opt_id tid = find_opt_uri tid.TextDocumentIdentifier.uri

let open_item doc = Hashtbl.replace current doc.TextDocumentItem.uri doc

let close = Hashtbl.remove current

let close_id tid = close tid.TextDocumentIdentifier.uri
