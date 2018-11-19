open Result

module type P = sig
  (* Parameters about the language *)
  val language_name : string
  val language_id : string

  (* Parameters about where to report stuff *)
  val inc : in_channel
  val outc : out_channel
  val logc : out_channel

end

module type S = sig
  val start : unit -> int
end

module Make (P : P) : S = struct

  let log_json j = Channels.log ((Yojson.Safe.pretty_to_string j) ^ "\n")

  let log_error e = log_json (ErrorCodes.to_yojson e)

  let out s = output_string P.outc s; flush P.outc

  let register_actions () = ()

  let rec loop () =
    let json_or_error = try (Rpc.read_yojson ())
      with End_of_file -> Error (ErrorCodes.InternalError "Nothing received... Something is wrong!")
    in
    let in_message_r = json_or_error ||> Message.of_yojson in
    (match in_message_r with
    | Ok im -> log_json (Message.to_yojson im)
    | Error e -> log_error e);
    let actions = InMessageHandler.handle in_message_r in
    let () = Action.execute_all actions in
    loop ()

  let start () =
    let () = P.( Channels.register ~inc ~outc ~logc ) in
    let () = register_actions () in
    loop ()

end

