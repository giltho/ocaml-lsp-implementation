module Make (Hooks : Hooks.S) = struct
  type 'b or_error = ('b, ErrorCodes.t) result

  type ('a, 'b) handler = 'a -> 'b or_error Lwt.t

  type 'b constructor = 'b -> ResponseMessage.Data.Success.t

  let initializeHandler (initParams : InitializeParams.t) :
      (InitializeResult.t, ErrorCodes.t) result Lwt.t =
    let () = State.Client.initialize ~initialize_params:initParams () in
    let init_res =
      InitializeResult.{ capabilities = State.Capabilities.implemented () }
    in
    Lwt.return (Ok init_res)

  let build_response (id : Json.json) (result : ('a, ErrorCodes.t) result)
      (constructor : 'a -> ResponseMessage.Data.Success.t) =
    let open ResponseMessage in
    match result with
    | Ok response -> { id; data = ResSuccess (constructor response) }
    | Error ec -> { id; data = ResError ec }

  let handling id params handler constructor =
    let%lwt result = handler params in
    Lwt.return (build_response id result constructor)

  let handle RequestMessage.{ id; method_ } =
    let handling = handling id in
    match method_ with
    | RInitialize params ->
        handling params initializeHandler (fun x -> SInitialize x)
end
