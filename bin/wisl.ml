let logc = open_out "test.log"

module Params : Lsp.P = struct
  let language_name = "test"
  let language_id = "test"

  let inc = stdin
  let outc = stdout
  let logc = logc
end

module Server : Lsp.S = Lsp.Make(Params)

let main () = 
  let r = Server.start () in
  close_out logc;
  exit r

let () = main ()