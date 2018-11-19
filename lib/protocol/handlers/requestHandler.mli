module type S = sig
  type params
  type result_content
  type error_data

  type error_content = ErrorCodes.t * error_data

  val handle : params -> (result_content, error_content) result
end

val handle : RequestMessage.t -> ResponseMessage.t