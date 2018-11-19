
type t = (CUri.t, TextDocumentItem.t) Hashtbl.t

let current : t = Hashtbl.create 10

let find_opt = Hashtbl.find_opt current

let open_t doc = Hashtbl.replace current doc.TextDocumentItem.uri doc

let close = Hashtbl.remove current
