(**
 * Describes the content type that a client supports in various
 * result literals like {!Lsp__textDocumentClientCapabilities.completionItemCapabilities},
 * `ParameterInfo` or `CompletionItem`.
 *
 * Please note that `MarkupKinds` must not start with a `$`. This kinds
 * are reserved for internal usage.
 *)

 type markupKind =
  | Markdown
  | Plaintext [@@deriving yojson]

type markupContent = {
  kind: markupKind;
  value: string;
} [@@deriving yojson]



