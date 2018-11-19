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

  let log_result ?(preok="") serialize res =
  match res with
    | Ok im -> Channels.log preok; log_json (serialize im)
    | Error e -> log_error e

  let error_count = ref 0

  let one_more_error () =
    error_count := !error_count + 1;
    if !error_count > 5 then exit 1
  

  let register_actions () = ()

  let rec loop () =
    let json_or_error = try (Rpc.read_yojson ())
      with
        End_of_file ->
        one_more_error ();
        Error (ErrorCodes.InternalError "Nothing received... Something is wrong!")
    in
    log_result ~preok:"Received\n" (fun x -> x) json_or_error;
    let in_message_r = json_or_error ||> Message.of_yojson in
    log_result ~preok:"Parsed\n" (Message.to_yojson) in_message_r;
    let actions = InMessageHandler.handle in_message_r in
    let () = Action.execute_all actions in
    loop ()

  let start () =
    let () = P.( Channels.register ~inc ~outc ~logc ) in
    let () = register_actions () in
    loop ()

end

