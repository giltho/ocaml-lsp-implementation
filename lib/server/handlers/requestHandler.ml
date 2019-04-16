
module Make () = struct

  type 'b or_error = ('b, ErrorCodes.t) result
  type ('a, 'b) handler = 'a -> 'b or_error Lwt.t
  type 'b constructor = 'b -> ResponseMessage.Data.Success.t

  let initializeHandler (initParams:InitializeParams.t) : ((InitializeResult.t, ErrorCodes.t) result) Lwt.t =
    let () = State.Client.initialize ~initialize_params:initParams () in
    let init_res = InitializeResult.{
      capabilities = State.Capabilities.implemented ()
    } in
    Lwt.return (Ok init_res)

  let build_response
    (id:Json.json)
    (result:('a, ErrorCodes.t) result)
    (constructor: 'a -> ResponseMessage.Data.Success.t) =
    let open ResponseMessage in
    match result with
    | Ok response -> { id; data=ResSuccess(constructor response) }
    | Error ec ->  { id; data=ResError ec }


  (* This function takes a request message "method", and returns :
   - the params
   - the associated handler
   - The Success Data Constructor for the response *)
  let destruct : RequestMessage.m -> 'a * ('a, 'b) handler * 'b constructor =
  let open RequestMessage in
  let open ResponseMessage.Data.Success in
  function
  | RInitialize params -> params, initializeHandler, (fun x -> SInitialize x)


  let handle RequestMessage.{ id; method_ } =
    let param, handler, constructor = destruct method_ in
    let%lwt result = handler param in
    Lwt.return (build_response id result constructor)

end