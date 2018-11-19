type t = {
  uri: CUri.t;
  languageId: string;
  version: int;
  text: string;
}[@@deriving yojson]