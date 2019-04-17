module type S = sig

  val onDidChangeContent : textDocument:Protocol.TextDocumentItem.t -> unit -> unit Lwt.t

end

module Default : S = struct

  let onDidChangeContent ~textDocument:_ () =
    Lwt.return ()

end