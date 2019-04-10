open Lsp.Scalars

let timeofday = string_of_float (Unix.gettimeofday ())

let logc = open_out ("test-" ^ timeofday ^ ".log")

module Params : Lsp.Server.P = struct
  let language_name = "test"

  let language_id = "test"

  let inc = stdin

  let outc = stdout

  let logc = logc

  module Hooks = struct
    let onDidChangeContent textDoc =
      let Lsp.TextDocument.{uri; _} = textDoc in
      let range =
        Range.
          { rstart= Position.{line= 0; character= 0}
          ; rend= Position.{line= 0; character= 3} }
      in
      let diag =
        Lsp.Diagnostic.
          { range
          ; severity= Some Lsp.Diagnostic.Severity.SevError
          ; message= "AAAAAAAAAA"
          ; code= None
          ; source= "wisl"
          ; relatedInformation= [] }
      in
      Lsp.Actions.diagnose uri [diag]
  end
end

module Server = Lsp.Server.Make (Params)

let main () =
  let r = Server.start () in
  close_out logc ; exit r

let () = main ()
