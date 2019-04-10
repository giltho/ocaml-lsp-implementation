module Severity = struct
  type t = SevError | SevWarning | SevInfo | SevHint [@@deriving yojson]
end

module RelatedInformation = struct
  type t = { location : Location.t; message : string } [@@deriving yojson]
end

type t = {
  range : Range.t;
  severity : Severity.t option;
  code : string option;
  source : string;
  message : string;
  relatedInformation : RelatedInformation.t list
}
[@@deriving yojson]
