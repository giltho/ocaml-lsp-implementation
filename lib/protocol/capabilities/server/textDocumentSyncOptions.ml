type t = {
  openClose : bool;
  change : TextDocumentSyncKind.t;
  willSave : bool;
  willSaveWaitUntil : bool;
  save : SaveOptions.t option;
}
[@@deriving yojson]
