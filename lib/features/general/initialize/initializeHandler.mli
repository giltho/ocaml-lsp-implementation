include RequestHandler.S
  (* TODO: is it necessary to expose those types ?*)
  with type params = InitializeParams.t
  and type result_content = InitializeResults.t
  and type error_data = unit