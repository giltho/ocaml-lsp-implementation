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

  let log s = output_string P.logc s

  let log_json j = Yojson.Safe.pretty_to_channel P.logc j

  let process_input () =
    let json = Rpc.read_message P.inc log in
    log_json json;
    `Stop 0

  let rec loop () =
    let a = process_input () in
    match a with
    | `Stop c -> c
    | `Continue -> loop ()

  let start () =
    let a = loop () in
    a
    
end

