open Graph
open Fulk
open Printf
open Tools 

type team = (id * int  * int * int)

type game = (id  * id * int * int)

type table = (team list * game list * team) 

let src_node_id = 0 

let sink_node_id = -1 

exception Table_error of string

let cantor_pairing (a,b) = 
let sort (x,y) = if x < y then (x,y) else (y,x) in (* values need to be sorted to give back the same output given two inputs*)
let vals = sort (a,b) in
(fst vals + snd vals)*(fst vals + snd vals + 1)/2 + snd vals 

let rec get_team tb tid = match tb with 
| ([],_,_) -> raise (Table_error ("team " ^ string_of_int tid ^ " does not exist in this table."))
| ((id,w,l,gr)::rest,games,st) -> if tid == id then (id,w,l,gr) else get_team (rest, games,st) tid 

let rec add_teams teams gr = match teams with 
| [] -> gr
| (id,_,_,_)::rest -> add_teams rest (new_node gr id)

let rec add_games games gr = match games with 
| [] -> gr
| (_,_,id,_)::rest -> add_games rest (new_node gr id)

let build_nodes table gr = match table with | (teams,games,st) -> (add_teams teams (add_games games (new_node (new_node gr src_node_id) sink_node_id) ) )

let rec build_game_arcs games gr = match games with
| [] -> gr 
| (t1,t2,gid,gamesRem)::rest -> build_game_arcs rest (new_arc (new_arc (new_arc gr gid t2 max_int) gid t1 max_int) src_node_id gid gamesRem)

let rec build_team_arcs teams gr team = match (teams,team) with
| ([],_) -> gr 
| ((id,w,l,gamesRem)::rest,(teamID,teamW,teamL,teamgamesRem)) -> let flow = (teamW + teamgamesRem - w) in if flow <=0 then build_team_arcs rest (new_arc gr id sink_node_id 0) team else build_team_arcs rest (new_arc gr id sink_node_id flow) team

let build_arcs table gr = match table with | (teams,games,st) -> build_game_arcs (games) (build_team_arcs (teams) gr st) 

let build_graph table = build_arcs table (build_nodes table empty_graph) 

let get_remaining_capacity_from_source gr src = let arcs = out_arcs gr src in List.fold_left (fun sum arc -> sum + snd arc) 0 arcs

let check_state_debug gr tb =   
let begin_flow = get_remaining_capacity_from_source gr src_node_id in Printf.printf " \n FLOW BEFORE %d \n %!" begin_flow ;
Printf.printf "\n GRAPH BEFORE \n %!" ; print_graph gr ;
let final_graph = fulk_debug gr src_node_id sink_node_id in 
Printf.printf "\n GRAPH AFTER \n %!" ; print_graph final_graph ;
let final_flow = get_remaining_capacity_from_source (final_graph) src_node_id in
Printf.printf " \n FLOW AFTER %d \n %!" final_flow ;
match tb with | (_,_,(_,_,_,tgr)) ->
if final_flow == 0 then true else false  

let check_state gr tb =   
let final_graph = fulk gr src_node_id sink_node_id in 
let final_flow = get_remaining_capacity_from_source (final_graph) src_node_id in
match tb with | (_,_,(_,_,_,tgr)) ->
if final_flow == 0 then true else false  

let empty_table = ([],[],(0,0,0,0)) 

let new_team tb id w l gr = match tb with | (teams,games,st) -> ((id,w,l,gr):: teams, games,st)

let new_selected_team tb id w l gr = match tb with | (teams,games,st) -> (teams, games, (id,w,l,gr)) 

let rec game_exist tb id = match tb with 
| (_,[],_) -> false 
| (teams, (_,_,gid,_)::rest,st) -> gid == id || game_exist (teams,rest,st) id 

let new_game tb t1 t2 gr = let gid = cantor_pairing (t1,t2) in 
match tb with | (teams,games,st) -> if game_exist (teams,games,st) gid then tb else (teams,(t1,t2,gid,gr) :: games,st)

let print_table tb = match tb with | (teams, games, st) -> 
Printf.printf "TEAMS \n %!" ; List.iter (fun (id,w,l,gr) -> Printf.printf "%d %d %d %d \n %!" id w l gr) teams ; 
Printf.printf "GAMES \n %!" ; List.iter (fun (t1,t2,gid,gr) -> Printf.printf "%d %d %d %d \n %!" t1 t2 gid gr) games;
Printf.printf "SELECTED TEAM \n %!" ; match st with | (tid,tw,tl,tgr) -> Printf.printf "%d %d %d %d \n %!" tid tw tl tgr



;;