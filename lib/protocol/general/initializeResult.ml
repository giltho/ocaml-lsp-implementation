(** Results of the initialize method only contain the server capabilities *)
type t = { capabilities : ServerCapabilities.t } [@@deriving yojson]
