type t =
  { line: int  (**
	 * Line position in a document (zero-based).
	 *)
  ; character: int
        (**
	 * Character offset on a line in a document (zero-based). Assuming that the line is
	 * represented as a string, the `character` value represents the gap between the
	 * `character` and `character + 1`.
	 *
	 * If the character value is greater than the line length it defaults back to the
	 * line length.
	 *)
  }
[@@deriving yojson]
