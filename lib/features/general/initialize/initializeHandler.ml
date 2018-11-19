type params = InitializeParams.t
type result_content = InitializeResults.t
type error_data = unit

type error_content = ErrorCodes.t * error_data

let handle InitializeParams.{ processId; rootUri; capabilities; trace } =
  if not (State.initialized ()) then
    let () = State.initialize processId rootUri capabilities trace in 
    Ok (InitializeResults.{
      capabilities = ServerCapabilities.implemented;
    })
  else
    Error (ErrorCodes.InvalidRequest "Server is already initialized !", ())
