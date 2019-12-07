open Graph
open Printf
open BaseballCase

type path = string

(* Reads a line with a team. *)
let read_team id table line stId =
  try Scanf.sscanf line "t %d %d %d" (fun w l gr -> if id == stId then (new_selected_team table stId w l gr) (*add the selected team in the table if id match the selected team id given as input *)
                                                                  else (new_team table id w l gr)) (*add a new team in the teams list of the table*)
  with e ->
    Printf.printf "Cannot read team in line - %s:\n%s\n%!" (Printexc.to_string e) line ;
    failwith "from_file"

(* Reads a line with a game. *)
let read_game table line stId =
  try Scanf.sscanf line "g %d %d %d" (fun id1 id2 gr -> if id1 == stId || id2 == stId then table else new_game table id1 id2 gr)
  with e ->
    Printf.printf "Cannot read game in line - %s:\n%s\n%!" (Printexc.to_string e) line ;
    failwith "from_file"

(* Reads a comment or fail. *)
let read_comment table line =
  try Scanf.sscanf line " %%" table
  with _ ->
    Printf.printf "Unknown line:\n%s\n%!" line ;
    failwith "from_file"

let from_file path stId =

  let infile = open_in path in

  (* Read all lines until end of file. 
   * n is the current node counter. *)
  let rec loop n table =
    try
      let line = input_line infile in

      (* Remove leading and trailing spaces. *)
      let line = String.trim line in

      let (n2, table2) =
        (* Ignore empty lines *)
        if line = "" then (n, table)

        (* The first character of a line determines its content : t or g. *)
        else match line.[0] with
          | 't' -> (n+1, read_team (n+1) table line stId)
          | 'g' -> (n, read_game table line stId)

          (* It should be a comment, otherwise we complain. *)
          | _ -> (n, read_comment table line)
      in      
      loop n2 table2

    with End_of_file -> table (* Done *)
  in

  let final_table = loop 0 empty_table in

  close_in infile ;
  final_table


