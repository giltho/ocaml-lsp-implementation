module Params : Lsp.P = struct
  let language_name = "test"
  let language_id = "test"

  let inc = stdin
  let outc = stdout
  let logc = stdout
end

module Server : Lsp.S = Lsp.Make(Params)

let main () = 
  let r = Server.start () in
  Printf.printf "Server ended with %d\n" r;
  exit r

let () = main ()