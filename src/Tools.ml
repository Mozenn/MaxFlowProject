open Graph

let clone_nodes (gr : 'a graph) = n_fold(gr)(new_node)(empty_graph);;

let gmap (gr :'a graph) (f : ('a -> 'b)) = e_fold (gr) (fun g id1 id2 a-> new_arc g id1 id2 (f a)) (clone_nodes(gr));;

let add_arc g id1 id2 n = 
    let res = find_arc(g)(id1)(id2) in match res with 
    | None -> new_arc(g)(id1)(id2)(n) (*Create arc if it does not exist*)
    | Some(x) -> let newValue = x + n in if newValue < 0 then new_arc(g)(id1)(id2)(0) else new_arc(g)(id1)(id2)(newValue);;

let print_graph gr = 
  Printf.printf "\n NODES \n %!" ; n_iter gr (fun id -> Printf.printf " %s %!" (string_of_int id) ) ; (* print nodes *)
  Printf.printf "\n EDGES \n %!" ; e_iter gr (fun src dest lb -> Printf.printf "src %d dest %d lb %d -> %!" src dest lb) ; (* print edges *)
  Printf.printf "\n %!"  ;; 
