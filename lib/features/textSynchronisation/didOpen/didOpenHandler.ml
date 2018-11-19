open DidOpenParams
open TextDocumentItem

type params = DidOpenParams.t

let handle { textDocument } =
  TextDocuments.open_t textDocument;
  Channels.log ("\nSuccessfuly opened document at uri : "
       ^ (Uri.to_string textDocument.TextDocumentItem.uri));
  Channels.log ("\nHere is the content :\n" ^ 
  (match TextDocuments.find_opt textDocument.TextDocumentItem.uri with
  | None -> "None"
  | Some text -> TextDocumentItem.(
    YojsonShort.json_to_string (to_yojson text)
  )
  ));
  ()