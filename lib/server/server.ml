open Cmdliner

module type P = sig end

module Make (P : P) = struct
  module MessageHandler = Handlers.MessageHandler.Make ()

  let log_channel = Lwt_io.open_file ~mode:Lwt_io.Output "LSP_LOG_FILE.log"

  let log s =
    let%lwt channel = log_channel in
    Lwt_io.write channel s

  let log_json json = log (Json.json_to_string json)

  let log_result res =
    let json =
      match res with
      | Ok message -> Protocol.Message.to_yojson message
      | Error ec -> Protocol.ErrorCodes.to_yojson ec
    in
    log_json json

  let rec loop () =
    let%lwt raw_json_res = Rpc.read_yojson () in
    let message_res =
      match raw_json_res with
      | Ok json -> Protocol.Message.of_yojson json
      | Error s -> Error (Protocol.ErrorCodes.ParseError s)
    in
    let _ = log_result message_res in
    let _ =
      match message_res with
      | Ok m -> MessageHandler.handle m
      | Error _ -> Lwt.return ()
    in
    loop ()

  let run () = Lwt_main.run (loop ())

  let start () = Term.(exit @@ eval (const run $ const (), info "Lsp"))
end
