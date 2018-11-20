module Params = struct

  type t = {
    textDocument: TextDocument.VersionedIdentifier.t;
    contentChanges: TextDocument.ContentChangeEvent.t list;
  }[@@deriving yojson]

end

module Handler = struct
  open Params

  type params = Params.t

  let handle { textDocument; contentChanges } =
    let doc = TextDocument.Manager.perform_changes textDocument contentChanges in
    let () =
      match doc with
      | Some docp -> Channels.log ("\nThe following document was updated :\n" ^
                                   (YojsonShort.json_to_string (TextDocument.Item.to_yojson docp) ^ "\n"));
      | None -> Channels.log "\nTried to update a file that was no opened\n" 
    in
    ()

end