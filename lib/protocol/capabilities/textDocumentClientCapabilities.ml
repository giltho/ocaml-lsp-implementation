(** This module defines textDocumentClientCapabilities. They are on of the
    component of {!ClientCapabilities} They are composed of several
    elements that we define and use in this module *)
module Synchronization = struct
  type t = {
    dynamicRegistration : (bool[@default false]);
    willSave : (bool[@default false]);
    willSaveWaitUntil : (bool[@default false]);
    didSave : (bool[@default false])
  }
  [@@deriving yojson { strict = false }]

  let default =
    Result.get (of_yojson (Json.o []))
end

module Completion = struct
  module CompletionItem = struct
    type t = {
      snippetSupport : (bool[@default false]);
      commitCharactersSupport : (bool[@default false]);
      deprecatedSupport : (bool[@default false]);
      preselectSupport : (bool[@default false]);
      documentationFormat : (MarkupKind.t list[@default []])
    }
    [@@deriving yojson { strict = false }]

    let default = Result.get(of_yojson (Json.o []))
  end

  module CompletionItemKind = struct
    type t = {
      valueSet : (CompletionItemKind.t list[@default []])
    }
    [@@deriving yojson { strict = false }]

    let default = { valueSet = [] }

  end

  type t = {
    dynamicRegistration : (bool[@default false]);
    completionItem :
      (CompletionItem.t [@default CompletionItem.default]);
    completionItemKind :
      (CompletionItemKind.t [@default CompletionItemKind.default]);
    contextSupport : (bool [@default false])
  }
  [@@deriving yojson { strict = false }]

  let default = Result.get (of_yojson (Json.o []))

end

module Hover = struct
  type t = {
  dynamicRegistration : (bool[@default false]);
  contentFormat : (MarkupKind.t list[@default []])
  }
  [@@deriving yojson { strict = false }]

  let default = Result.get (of_yojson (Json.o []))
end


module SignatureHelp = struct

  module SignatureInformation = struct

    module ParameterInformation = struct
      type t = {
        labelOffsetSupport : bool [@default false]
      }
      [@@ deriving yojson { strict = false }]

      let default = Result.get (of_yojson (Json.o []))

    end

    type t = {
      documentationFormat : MarkupKind.t list [@default ([ MarkupKind.Plaintext ])];
      parameterInformation : ParameterInformation.t [@default ParameterInformation.default]
    }
    [@@deriving yojson { strict = false }]

    let default = Result.get (of_yojson (Json.o []))

  end

  type t = {
    dynamicRegistration : (bool[@default false]);
    signatureInformation : (SignatureInformation.t [@default SignatureInformation.default])
  }
  [@@deriving yojson]

  let default = Result.get (of_yojson (Json.o []))
end

type t = {
  synchronisation : Synchronization.t [@default  Synchronization.default];
  completion : Completion.t [@default Completion.default];
  hover : Hover.t [@default Hover.default];
  signatureHelp : SignatureHelp.t [@default SignatureHelp.default];
}
[@@deriving yojson { strict = false }]

let default = Result.get (of_yojson (Json.o []))
