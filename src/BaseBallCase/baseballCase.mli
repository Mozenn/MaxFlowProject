
open Graph

(*
team : id wins losses remainingGames 
*)
type team = (id * int  * int * int)

(*
game : team1ID team2ID gameID remainingGames
the game id computed with cantor_pairing and is unique for each combination of teams 
*)
type game = (id  * id * int * int)

(*
team : teams games selectedTeamToTest
*)
type table = (team list * game list * team)

(*
constant id given to the source of the graph built from a table 
*)
val src_node_id : id

(*
constant id given to the sink of the graph built from a table 
*)
val sink_node_id : id

exception Table_error of string

(*
cantor_pairing (team1ID * team2ID) 
used to have unique game id from two team id 
*)
val cantor_pairing : (int*int) -> int 

(*
new_team table id wins losses gamesRemaining 
adds a new team to a table 
*)
val new_team : table -> id -> int -> int -> int -> table 

(*
new_selected_team table id wins losses gamesRemaining 
adds a new selected team to be tested or replace the current one 
*)
val new_selected_team : table -> id -> int -> int -> int -> table 

(*
get_team table teamID
get the team given a teamID 
* @raise Table_error if teamID is not in the table
*)
val get_team : table -> id -> team 

(*
game table team1Id team2Id gamesRemaining 
adds a new game to a table 
return table untouched if game between team1 and team2 already in table
*)
val new_game : table -> id -> id -> int -> table 
(*
game_exist table gameID 
Check if a game is already in the table given a gameID computed with cantor_pairing 
*)
val game_exist : table -> int -> bool 

(*
empty_table 
return an empty table 
*)
val empty_table : table 

(*
build_graph table 
build an int graph from a table 
the graph is build like this :
- a source link to all games node with number of games remaining as capacity of the arcs 
- games node between two teams are link to the two teams playing with infinite capacity
- teams node link to a sink with capacity of arcs computed following this formlula : selectedTeamWins + selectedTeamGamesRemaining - currentTeamWins
*)
val build_graph : table -> int graph 

(*
check_state graph table 
Return true if the selected team in table can still be first given the state of the table 
False otherwise 
*)
val check_state : int graph -> table ->  bool ;; 

(*
check_state graph table 
Same as check_state but with printing 
*)
val check_state_debug : int graph -> table ->  bool ;; 

(*
print_table table
print the teams, games and selected team contained in the table 
*)
val print_table : table -> unit 

(*
get_remaining_capacity_from_source gr src 
return the sum the remaining capacity of all arcs leaving the source 
*)
val get_remaining_capacity_from_source : int graph -> id -> int ;;