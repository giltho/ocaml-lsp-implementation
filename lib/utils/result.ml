type ('a, 'b) t = ('a, 'b) result =
  | Ok of 'a
  | Error of 'b

let get res = match res with Ok a -> a | Error b -> failwith b

let ( ||> ) result fct = match result with Ok a -> fct a | Error b -> Error b
