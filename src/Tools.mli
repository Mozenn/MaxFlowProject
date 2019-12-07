open Graph

(* clone_nodes gr : remove the arcs of the input graph *)
val clone_nodes: 'a graph -> 'b graph

(*gmap gr f : map all arcs of gr by function f*)
val gmap: 'a graph -> ('a -> 'b) -> 'b graph

(*add_arc g id1 id2 n : adds n to the value of the arc between id1 and id2. If the arc does not exist, it is created *)
val add_arc: int graph -> id -> id -> int -> int graph

(* print_graph gr : print nodes & edges of a given graph *)
val print_graph : int graph -> unit
