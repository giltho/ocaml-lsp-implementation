type 'a t = ('a, string) Pervasives.result

let get res =
    match res with
    | Ok a -> a
    | Error b -> failwith b