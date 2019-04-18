open Server

module Params : P = struct

  module Hooks = struct
    include Hooks.Default
    open Protocol

    let onDidChangeContent ~textDocument () =
      let open TextDocumentItem in
      if textDocument.text = "aaaa" then
        let range = Range.{
          start = Position.{
            line = 1;
            character = 1;
          };
          end_ = Position.{
            line = 1;
            character = 5;
          }
        }
        in
        let diagnostics = PublishDiagnosticsParams.{
          uri = textDocument.uri;
          diagnostics = [
            Diagnostic.{
              range;
              severity = Some DiagnosticSeverity.Information;
              code = None;
              source = "testServer";
              message = "IT IS PRINTED AAAAAAA";
              relatedInformation = []
            }
          ]
        }
        in
        let _ = Actions.Notify.publishDiagnostics diagnostics in
        Lwt.return ()
      else
        Lwt.return ()

  end

end

module MyServer = Server.Make (Params)

let () = MyServer.start ()
