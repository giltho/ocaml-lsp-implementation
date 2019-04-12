open Server

module Params : P = struct
end

module MyServer = Server.Make (Params)

let () = MyServer.start ()
