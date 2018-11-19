module Identifier = struct

  type t = {
    uri: CUri.t
  }[@@deriving yojson]

end

module Item = struct

  type t = {
    uri: CUri.t;
    languageId: string;
    version: int;
    text: string;
  }[@@deriving yojson]

end

module Manager = struct

  type t = (CUri.t, Item.t) Hashtbl.t

  let current : t = Hashtbl.create 10

  let find_opt_uri = Hashtbl.find_opt current

  let find_opt_id tid = find_opt_uri tid.Identifier.uri

  let open_item doc = Hashtbl.replace current doc.Item.uri doc

  let close = Hashtbl.remove current

  let close_id tid = close tid.Identifier.uri

end