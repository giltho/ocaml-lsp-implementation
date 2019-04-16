open Server

module Params : P = struct

  module Hooks = struct
    include Hooks.Default
  end

end

module MyServer = Server.Make (Params)

let () = MyServer.start ()
