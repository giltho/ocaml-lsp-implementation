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

  let log s = output_string P.logc s; flush P.logc

  let log_json j = log (Yojson.Safe.pretty_to_string j)

  let log_error e = log (ErrorCodes.to_string e)

  let process_input () =
    let json_or_error = try (Rpc.read_message ~log P.inc)
      with End_of_file -> Error (ErrorCodes.InternalError "Nothing received... Closing !")
    in
    let parsed_content = json_or_error ||> InMessage.of_yojson in
    match parsed_content with
    | Ok im -> failwith "mytho pas wesh"
    | Error e -> log_error e; `Stop 1

  let rec loop () =
    let a = process_input () in
    match a with
    | `Stop c -> c
    | `Continue -> loop ()

  let start () =
    let a = loop () in
    a

end

