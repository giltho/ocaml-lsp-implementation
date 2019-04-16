let _implemented =
  ref
    ServerCapabilities.
      { hoverProvider = false;
        definitionProvider = false;
        completionProvider = None;
        textDocumentSync =
          { openClose = true;
            change = TextDocumentSyncKind.TDSKFull;
            willSave = false;
            willSaveWaitUntil = false;
            save = None
          }
      }

let implemented () = !_implemented
