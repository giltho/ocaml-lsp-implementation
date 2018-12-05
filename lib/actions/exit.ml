let before_exit = ref (fun () -> ())

let register_before_exit f = before_exit := f

let exit () = exit 0
