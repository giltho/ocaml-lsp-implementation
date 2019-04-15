let _root_uri = ref DocumentUri.empty

let _client_capabilities = ref ClientCapabilities.default

let _trace = ref Trace.TOff

let _parent_process_id = ref None

let _initialized = ref false

let initialized () = !_initialized

let initialize
  ~initialize_params
  () =
  let InitializeParams.{
    processId;
    rootUri;
    capabilities;
    trace;
  } = initialize_params in
  _parent_process_id := processId;
  _root_uri := rootUri;
  _client_capabilities := capabilities;
  _trace := trace