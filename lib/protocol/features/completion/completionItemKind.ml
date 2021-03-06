type t =
  | Text
  | Method
  | Function
  | Constructor
  | Field
  | Variable
  | Class
  | Interface
  | Module
  | Property
  | Unit
  | Value
  | Enum
  | Keyword
  | Snippet
  | Color
  | File
  | Reference
  | Folder
  | EnumMember
  | Constant
  | Struct
  | Event
  | Operator
  | TypeParameter

let to_int = function
  | Text -> 1
  | Method -> 2
  | Function -> 3
  | Constructor -> 4
  | Field -> 5
  | Variable -> 6
  | Class -> 7
  | Interface -> 8
  | Module -> 9
  | Property -> 10
  | Unit -> 11
  | Value -> 12
  | Enum -> 13
  | Keyword -> 14
  | Snippet -> 15
  | Color -> 16
  | File -> 17
  | Reference -> 18
  | Folder -> 19
  | EnumMember -> 20
  | Constant -> 21
  | Struct -> 22
  | Event -> 23
  | Operator -> 24
  | TypeParameter -> 25

let to_yojson k = `Int (to_int k)

let of_yojson = function
  | `Int 1 | `Float 1. -> Ok Text
  | `Int 2 | `Float 2. -> Ok Method
  | `Int 3 | `Float 3. -> Ok Function
  | `Int 4 | `Float 4. -> Ok Constructor
  | `Int 5 | `Float 5. -> Ok Field
  | `Int 6 | `Float 6. -> Ok Variable
  | `Int 7 | `Float 7. -> Ok Class
  | `Int 8 | `Float 8. -> Ok Interface
  | `Int 9 | `Float 9. -> Ok Module
  | `Int 10 | `Float 10. -> Ok Property
  | `Int 11 | `Float 11. -> Ok Unit
  | `Int 12 | `Float 12. -> Ok Value
  | `Int 13 | `Float 13. -> Ok Enum
  | `Int 14 | `Float 14. -> Ok Keyword
  | `Int 15 | `Float 15. -> Ok Snippet
  | `Int 16 | `Float 16. -> Ok Color
  | `Int 17 | `Float 17. -> Ok File
  | `Int 18 | `Float 18. -> Ok Reference
  | `Int 19 | `Float 19. -> Ok Folder
  | `Int 20 | `Float 20. -> Ok EnumMember
  | `Int 21 | `Float 21. -> Ok Constant
  | `Int 22 | `Float 22. -> Ok Struct
  | `Int 23 | `Float 23. -> Ok Event
  | `Int 24 | `Float 24. -> Ok Operator
  | `Int 25 | `Float 25. -> Ok TypeParameter
  | other -> Error (Yojson.Safe.to_string other)
