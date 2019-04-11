type t = {
  rootUri : DocumentUri.t;
  clientCapabilities : ClientCapabilities.t;
  trace : Trace.t;
  parentProcessId : int option
}

(* [@@deriving yojson] *)

(** Initial state *)
let current =
  ref
    { rootUri = DocumentUri.empty;
      clientCapabilities = ClientCapabilities.default;
      trace = Trace.TOff;
      parentProcessId = None
    }

let is_initialized = ref false

let get () = !current

let set s = current := s

let initialize parentProcessId rootUri clientCapabilities trace =
  let () = is_initialized := true in
  set { parentProcessId; clientCapabilities; rootUri; trace }

(* Channels.log (YojsonShort.json_to_string (to_yojson !current)) *)

let initialized () = !is_initialized
