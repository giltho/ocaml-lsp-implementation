type t = {
  range : Range.t option; [@default None]
      (** The range of the document that changed. *)
  rangeLength : int option; [@default None]
      (** The length of the range that got replaced. *)
  text : string  (** The new text of the range/textDocument *)
}
[@@deriving yojson]