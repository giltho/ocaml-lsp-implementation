type t = {logc: out_channel; outc: out_channel; inc: in_channel}

let current = ref {logc= stdout; inc= stdin; outc= stdout}

let register ~inc ~outc ~logc = current := {inc; outc; logc}

let log s =
  Printf.fprintf !current.logc "%s" s ;
  flush !current.logc

let out s =
  let () = log ("OUT:\n" ^ s) in
  Printf.fprintf !current.outc "%s" s ;
  flush !current.outc

let get_inc () = !current.inc
