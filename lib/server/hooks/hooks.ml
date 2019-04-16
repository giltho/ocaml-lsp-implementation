module type S = sig

  val onDidChangeDocument : textDocument:Protocol.TextDocumentItem.t -> unit -> unit Lwt.t

end

module Default : S = struct

  let onDidChangeDocument ~textDocument:_ () =
    Lwt.return ()

end