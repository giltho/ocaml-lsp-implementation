type t =
  | Exit of int
  | Respond of ResponseMessage.t

let execute action =
  match action with
  | Exit r -> Exit.exit ()
  | Respond rm -> Rpc.write_yojson
    (Message.to_yojson (Message.MResponse rm))

let execute_all actions = List.iter execute actions