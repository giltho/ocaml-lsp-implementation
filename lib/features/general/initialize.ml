module Params = struct
  type t =
    { processId: (int option[@default None])
    ; rootUri: (CUri.t[@default Uri.empty])
    ; capabilities: (ClientCapabilities.t[@default ClientCapabilities.default])
    ; (* TODO: workspaceFolders : workspaceFolders.t; *)
      trace: Trace.t [@default Trace.TOff] }
  [@@deriving yojson {strict= false}]
end

module Results = struct
  type t = {capabilities: ServerCapabilities.t} [@@deriving yojson]
end

module Handler = struct
  type params = Params.t

  type result_content = Results.t

  type error_data = unit

  type error_content = ErrorCodes.t * error_data

  let handle Params.{processId; rootUri; capabilities; trace} =
    if not (State.initialized ()) then
      let () = State.initialize processId rootUri capabilities trace in
      Ok Results.{capabilities= ServerCapabilities.implemented}
    else Error (ErrorCodes.InvalidRequest "Server is already initialized !", ())
end
