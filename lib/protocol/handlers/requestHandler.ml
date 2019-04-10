(** Refactoring of response messages ? Something isn't completely smooth here... *)
let handle RequestMessage.{rId; rMethod} =
  match rMethod with
  | RInitialize ip -> (
      let data_or_error = Initialize.Handler.handle ip in
      match data_or_error with
      | Ok result ->
          ResponseMessage.
            {resId= rId; resData= ResSuccess (SInitialize result)}
      | Error (error, _) ->
          ResponseMessage.{resId= rId; resData= ResError error} )
