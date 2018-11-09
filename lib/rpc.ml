open YojsonShort

let read_message (inc: in_channel) (log: string -> unit) : json =
  let content_length_line = input_line inc in
  let content_length = 