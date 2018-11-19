module type S = sig
  type params
  type result_content
  type error_data

  type error_content = ErrorCodes.t * error_data

  val handle : params -> (result_content, error_content) result
end

(** Refactoring of response messages ? Something isn't completely smooth here... *)
let handle RequestMessage.{ rId; rMethod }=
  match rMethod with
  | RInitialize ip ->
    begin
    let data_or_error = InitializeHandler.handle ip in
    match data_or_error with
    | Ok result -> ResponseMessage.{
      resId = rId;
      resData = ResSuccess (SInitialize result)
    }
    | Error (error, _) -> ResponseMessage.{
      resId = rId;
      resData = ResError error;
    } 
    end
