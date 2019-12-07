# Ford Fulkerson Algorithm 

## Compile
Run "ocamlbuild src/Fulkerson/ftest.native" command in MaxFlowProject/ folder

## Test 
Run "./ftest.native input source sink output" command in MaxFlowProject/ folder where \
    - input is the path of the file containing the initial graph. Some graphs can be found in MaxFlowProject/graphs folder \
    - source and sink are the ids of the nodes to run Ford Fulkerson on. Those ids must exist in the chosen input file \
    - output is the path of the file where the resulting graph is written 

# Baseball Elimination 

## Compile 
Run "ocamlbuild src/BaseBallCase/btest.native" command in MaxFlowProject/ folder

## Test 
Run "./btest.native input selectedTeamID" command in MaxFlowProject/ folder where \
    - input is the path of the file containing the state of the game to test on. Some state examples can be found in MaxFlowProject/baseballCase folder \
    - selectedTeamID is the id of the team (according to the input file) to check \
An output in the terminal will state if the selected team is eliminated or can still be first \
