open Cmdliner

module type P = sig

  module Hooks : Hooks.S

end

module Make (P : P) = struct
  module MessageHandler = Handlers.MessageHandler.Make (P.Hooks)

  let rec loop () =
    let%lwt raw_json_res = Rpc.read_yojson () in
    let message_res =
      match raw_json_res with
      | Ok json -> Protocol.Message.of_yojson json
      | Error s -> Error (Protocol.ErrorCodes.ParseError s)
    in
    let _ =
      Actions.Log.log_result ~to_json:Protocol.Message.to_yojson message_res
    in
    let _ =
      match message_res with
      | Ok m -> MessageHandler.handle m
      | Error _ -> Lwt.return ()
    in
    loop ()

  let start_server () =
    let%lwt log_channel =
      Lwt_io.open_file ~mode:Lwt_io.Output "LSP_LOG_FILE.log"
    in
    let () = State.Internal.set_log_channel log_channel in
    loop ()

  let run () = Lwt_main.run (start_server ())

  let start () = Term.(exit @@ eval (const run $ const (), info "Lsp"))
end
