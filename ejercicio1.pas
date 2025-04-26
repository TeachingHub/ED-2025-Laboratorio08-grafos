program ejercicio1;

uses
  sysutils, uListaEnlazadaDoble, uMatrixEdgeWeightedDigraph;

procedure PrintHeader(title: string);
begin
  writeln;
  writeln('--------------------------------------------------');
  writeln(title);
  writeln('--------------------------------------------------');
end;

procedure TestInitialize();
var
  g: edgeWeightedDigraph;
begin
  PrintHeader('Test Initialize');
  initialize(g);
  writeln('Graph initialized. Is empty? ', is_empty(g));
  
  if is_empty(g) then
    writeln('PASSED: Graph is correctly initialized and empty')
  else
    writeln('FAILED: Graph should be empty after initialization');
end;

procedure TestAddNodes();
var
  g: edgeWeightedDigraph;
begin
  PrintHeader('Test Add Nodes');
  initialize(g);
  
  writeln('Adding nodes: A, B, C, D, E');
  add_node(g, 'A');
  add_node(g, 'B');
  add_node(g, 'C');
  add_node(g, 'D');
  add_node(g, 'E');
  
  writeln('Number of nodes after adding: ', g.num_nodes);
  writeln('Is node A in graph? ', node_in_graph(g, 'A'));
  writeln('Is node F in graph? ', node_in_graph(g, 'F'));
  
  writeln('Trying to add node A again (duplicate)');
  add_node(g, 'A');
  writeln('Number of nodes after trying to add duplicate: ', g.num_nodes);
  
  if (g.num_nodes = 5) and node_in_graph(g, 'A') and not node_in_graph(g, 'F') then
    writeln('PASSED: Nodes added correctly')
  else
    writeln('FAILED: Issue with adding nodes');
end;

procedure TestAddEdges();
var
  g: edgeWeightedDigraph;
begin
  PrintHeader('Test Add Edges');
  initialize(g);
  
  writeln('Adding nodes: A, B, C, D');
  add_node(g, 'A');
  add_node(g, 'B');
  add_node(g, 'C');
  add_node(g, 'D');
  
  writeln('Adding edges:');
  writeln('A->B with weight 5');
  add_edge(g, 'A', 'B', '5');
  writeln('B->C with weight 10');
  add_edge(g, 'B', 'C', '10');
  writeln('C->D with weight 3');
  add_edge(g, 'C', 'D', '3');
  writeln('D->A with weight 7');
  add_edge(g, 'D', 'A', '7');
  writeln('A->C with weight 2');
  add_edge(g, 'A', 'C', '2');
  
  writeln('Showing graph:');
  show(g);
  
  writeln('Edge A->B exists? ', edge_in_graph(g, 'A', 'B'));
  writeln('Edge B->A exists? ', edge_in_graph(g, 'B', 'A'));
  writeln('Weight of edge A->B: ', edge_weight(g, 'A', 'B'));
  
  if edge_in_graph(g, 'A', 'B') and not edge_in_graph(g, 'B', 'A') and (edge_weight(g, 'A', 'B') = '5') then
    writeln('PASSED: Edges added correctly')
  else
    writeln('FAILED: Issue with adding edges');
end;

procedure TestAdjacent();
var
  g: edgeWeightedDigraph;
begin
  PrintHeader('Test Adjacent');
  initialize(g);
  
  add_node(g, 'A');
  add_node(g, 'B');
  add_node(g, 'C');
  
  add_edge(g, 'A', 'B', '5');
  add_edge(g, 'B', 'C', '10');
  
  writeln('Is A adjacent to B? ', adjacent(g, 'A', 'B'));
  writeln('Is B adjacent to A? ', adjacent(g, 'B', 'A'));
  writeln('Is B adjacent to C? ', adjacent(g, 'B', 'C'));
  
  if adjacent(g, 'A', 'B') and not adjacent(g, 'B', 'A') and adjacent(g, 'B', 'C') then
    writeln('PASSED: Adjacent function works correctly')
  else
    writeln('FAILED: Issue with adjacent function');
end;

procedure TestDegrees();
var
  g: edgeWeightedDigraph;
begin
  PrintHeader('Test Degrees');
  initialize(g);
  
  add_node(g, 'A');
  add_node(g, 'B');
  add_node(g, 'C');
  add_node(g, 'D');
  
  add_edge(g, 'A', 'B', '5');
  add_edge(g, 'A', 'C', '3');
  add_edge(g, 'B', 'C', '2');
  add_edge(g, 'C', 'A', '6');
  add_edge(g, 'D', 'A', '4');
  
  writeln('Node A - outdegree: ', outdegree(g, 'A'), ', indegree: ', indegree(g, 'A'), ', total degree: ', degree(g, 'A'));
  writeln('Node B - outdegree: ', outdegree(g, 'B'), ', indegree: ', indegree(g, 'B'), ', total degree: ', degree(g, 'B'));
  writeln('Node C - outdegree: ', outdegree(g, 'C'), ', indegree: ', indegree(g, 'C'), ', total degree: ', degree(g, 'C'));
  writeln('Node D - outdegree: ', outdegree(g, 'D'), ', indegree: ', indegree(g, 'D'), ', total degree: ', degree(g, 'D'));
  
  if (outdegree(g, 'A') = 2) and (indegree(g, 'A') = 2) and (degree(g, 'A') = 4) then
    writeln('PASSED: Degree functions work correctly')
  else
    writeln('FAILED: Issue with degree functions');
end;

procedure TestWeightedDegrees();
var
  g: edgeWeightedDigraph;
begin
  PrintHeader('Test Weighted Degrees');
  initialize(g);
  
  add_node(g, 'A');
  add_node(g, 'B');
  add_node(g, 'C');
  
  add_edge(g, 'A', 'B', '5');
  add_edge(g, 'A', 'C', '3');
  add_edge(g, 'B', 'C', '2');
  add_edge(g, 'C', 'A', '6');

  show_matrix(g);
  
  writeln('Node A - weighted outdegree: ', weighted_outdegree(g, 'A'), ', weighted indegree: ', weighted_indegree(g, 'A'));
  writeln('Node B - weighted outdegree: ', weighted_outdegree(g, 'B'), ', weighted indegree: ', weighted_indegree(g, 'B'));
  writeln('Node C - weighted outdegree: ', weighted_outdegree(g, 'C'), ', weighted indegree: ', weighted_indegree(g, 'C'));
  
  if (weighted_indegree(g, 'A') = 6) and (weighted_outdegree(g, 'A') = 8) 
      and (weighted_indegree(g, 'B') = 5) and (weighted_outdegree(g, 'B') = 2) then
    writeln('PASSED: Weighted degree functions work correctly')
  else
    writeln('FAILED: Issue with weighted degree functions');
end;

procedure TestDeleteEdgeAndNode();
var
  g: edgeWeightedDigraph;
begin
  PrintHeader('Test Delete Edge and Node');
  initialize(g);
  
  add_node(g, 'A');
  add_node(g, 'B');
  add_node(g, 'C');
  
  add_edge(g, 'A', 'B', '5');
  add_edge(g, 'B', 'C', '10');
  add_edge(g, 'C', 'A', '7');
  
  writeln('Graph before deletions:');
  show(g);
  
  writeln('Deleting edge B->C');
  delete_edge(g, 'B', 'C');
  writeln('Edge B->C exists? ', edge_in_graph(g, 'B', 'C'));
  
  writeln('Deleting node B');
  delete_node(g, 'B');
  writeln('Node B exists? ', node_in_graph(g, 'B'));
  writeln('Number of nodes after deletion: ', g.num_nodes);
  
  writeln('Graph after deletions:');
  show(g);
  
  if (not edge_in_graph(g, 'B', 'C')) and (not node_in_graph(g, 'B')) and (g.num_nodes = 2) then
    writeln('PASSED: Delete functions work correctly')
  else
    writeln('FAILED: Issue with delete functions');
end;

procedure TestSelfLoops();
var
  g: edgeWeightedDigraph;
begin
  PrintHeader('Test Self Loops');
  initialize(g);
  
  add_node(g, 'A');
  add_node(g, 'B');
  
  writeln('Before adding self loop - has self loops? ', has_self_loops(g));
  
  add_edge(g, 'A', 'A', '3');
  
  writeln('After adding self loop A->A - has self loops? ', has_self_loops(g));
  
  if has_self_loops(g) then
    writeln('PASSED: Self loop detection works correctly')
  else
    writeln('FAILED: Issue with self loop detection');
end;

procedure TestDensity();
var
  g: edgeWeightedDigraph;
begin
  PrintHeader('Test Density');
  initialize(g);
  
  add_node(g, 'A');
  add_node(g, 'B');
  add_node(g, 'C');
  
  add_edge(g, 'A', 'B', '5');
  add_edge(g, 'B', 'C', '10');
  
  writeln('Graph density: ', density(g));
  
  if (density(g) = 1/3) then
    writeln('PASSED: Density calculation works correctly')
  else
    writeln('FAILED: Issue with density calculation');
end;

procedure TestIsComplete();
var
  g, gc: edgeWeightedDigraph;
begin
  PrintHeader('Test Is Complete');
  initialize(g);
  initialize(gc);

  add_node(g, 'A');
  add_node(g, 'B');
  add_node(g, 'C');
  add_node(gc, 'A');
  add_node(gc, 'B');
  add_node(gc, 'C');
  add_edge(g, 'A', 'B', '5');
  add_edge(g, 'B', 'C', '10');
  add_edge(g, 'C', 'A', '7');
  add_edge(gc, 'A', 'B', '1');
  add_edge(gc, 'A', 'C', '1');
  add_edge(gc, 'B', 'C', '1');
  add_edge(gc, 'B', 'A', '1');
  add_edge(gc, 'C', 'A', '1');
  add_edge(gc, 'C', 'B', '1');
  writeln('Graph g is complete? ', is_complete(g));
  writeln('Graph gc is complete? ', is_complete(gc));
  if (not is_complete(g)) and is_complete(gc) then
    writeln('PASSED: Complete graph detection works correctly')
  else
    writeln('FAILED: Issue with complete graph detection');
end;

procedure TestNeighbors();
var
  g: edgeWeightedDigraph;
  neighbors_list, correct: tListaDoble;
begin
  PrintHeader('Test Neighbors');
  initialize(g);

  add_node(g, 'A');
  add_node(g, 'B');
  add_node(g, 'C');

  add_edge(g, 'A', 'B', '5');
  add_edge(g, 'A', 'C', '3');

  writeln('Finding neighbors of A...');
  neighbors(g, 'A', neighbors_list);
  uListaEnlazadaDoble.initialize(correct);
  insert_at_end(correct, 'B');
  insert_at_end(correct, 'C');
  if (to_string(neighbors_list) = to_string(correct)) then
    writeln('PASSED: Neighbors function works correctly')
  else
    writeln('FAILED: Issue with neighbors function');
end;




begin
  TestInitialize();
  readln;
  TestAddNodes();
  readln;
  TestAddEdges();
  readln;
  TestAdjacent();
  readln;
  TestDegrees();
  readln;
  TestWeightedDegrees();
  readln;
  TestDeleteEdgeAndNode();
  readln;
  TestSelfLoops();
  readln;
  TestDensity();
  readln;
  TestIsComplete();
  readln;
  TestNeighbors();
  readln;
  
  writeln;
  writeln('All tests completed.');
  writeln('Press Enter to exit...');
  readln;
end.