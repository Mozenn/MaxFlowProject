open Graph

(* arc src destination label
Type representing an arc in a flow graph 
Used to define a path returned by find_chain method 
An arc is define by a source node id, a destination node id and a label
*)
type 'a arc = (id * id *'a)

(*
Type return by find_chain method 
Consist of a list of arcs representing the path found and a list of node id representing all the encountered nodes
The list of node id is not important for the final result but is used in the recursion of find_chain to keep track of the marked nodes when backtracking 
*)
type 'a chain_res = (('a arc) list  * id list)

(*
find_chain gr src sink acu marked 
return the first encountered path from the src to the sink and a list of the nodes id marked during the search 
called by fulk method 
 *)
val find_chain: int graph -> id -> id -> (int arc) list -> id list -> int chain_res


(*
find_flow path
return the amount of flow that can be added to the arcs  
called by fulk method 
*)
val find_flow: (int arc) list -> int 

(*
fulk gr src sink
Maximize the flow between src and sink if a path exist in gr 
if not path found, flow is already maximal and gr is untouched 
*)
val fulk: int graph -> id -> id -> int graph 

(*
fulk gr src sink
Same as fulk but with printing 
*)
val fulk_debug : int graph -> id -> id -> int graph 

