program ejercicio2;

uses
  sysutils, uListEdgeWeightedGraph;
procedure PrintHeader(title: string);
begin
  writeln;
  writeln('--------------------------------------------------');
  writeln(title);
  writeln('--------------------------------------------------');
end;

procedure TestInitialize();
var
  g: edgeWeightedGraph;
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
  g: edgeWeightedGraph;
begin
  PrintHeader('Test Add Nodes');
  initialize(g);
  
  writeln('Adding nodes: A, B, C, D, E');
  add_node(g, 'A');
  add_node(g, 'B');
  add_node(g, 'C');
  add_node(g, 'D');
  add_node(g, 'E');
  
  writeln('Number of nodes after adding: ', num_nodes(g));
  writeln('Is node A in graph? ', node_in_graph(g, 'A'));
  writeln('Is node F in graph? ', node_in_graph(g, 'F'));
  
  writeln('Trying to add node A again (duplicate)');
  add_node(g, 'A');
  writeln('Number of nodes after trying to add duplicate: ', num_nodes(g));
  
  if (num_nodes(g) = 5) and node_in_graph(g, 'A') and not node_in_graph(g, 'F') then
    writeln('PASSED: Nodes added correctly')
  else
    writeln('FAILED: Issue with adding nodes');
end;

procedure TestAddEdges();
var
  g: edgeWeightedGraph;
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
  add_edge(g, 'A', 'B', 5);
  writeln('B->C with weight 10');
  add_edge(g, 'B', 'C', 10);
  writeln('C->D with weight 3');
  add_edge(g, 'C', 'D', 3);
  writeln('D->A with weight 7');
  add_edge(g, 'D', 'A', 7);
  writeln('A->C with weight 2');
  add_edge(g, 'A', 'C', 2);
  
  writeln('Showing graph:');
  show(g);
  
  writeln('Edge A->B exists? ', edge_in_graph(g, 'A', 'B'));
  writeln('Edge B->A exists? ', edge_in_graph(g, 'B', 'A'));
  writeln('Weight of edge A->B: ', edge_weight(g, 'A', 'B'));
  
  if edge_in_graph(g, 'A', 'B') and (edge_weight(g, 'A', 'B') = 5) then
    writeln('PASSED: Edges added correctly')
  else
    writeln('FAILED: Issue with adding edges');
end;

procedure TestAdjacent();
var
  g: edgeWeightedGraph;
begin
  PrintHeader('Test Adjacent');
  initialize(g);
  
  add_node(g, 'A');
  add_node(g, 'B');
  add_node(g, 'C');
  add_node(g, 'D');
  
  add_edge(g, 'A', 'B', 5);
  add_edge(g, 'B', 'C', 10);
  add_edge(g, 'C', 'D', 3);
  
  writeln('Is A adjacent to B? ', adjacent(g, 'A', 'B'));
  writeln('Is B adjacent to A? ', adjacent(g, 'B', 'A'));
  writeln('Is B adjacent to C? ', adjacent(g, 'B', 'C'));
  writeln('Is C adjacent to A? ', adjacent(g, 'C', 'A'));
  writeln('Is D adjacent to C? ', adjacent(g, 'D', 'C'));
  
  if adjacent(g, 'A', 'B') and adjacent(g, 'B', 'A') and
     adjacent(g, 'B', 'C') and not adjacent(g, 'C', 'A') and
     adjacent(g, 'D', 'C') then
    writeln('PASSED: Adjacent function works correctly')
  else
    writeln('FAILED: Issue with adjacent function');
end;

procedure TestDegrees();
var
  g: edgeWeightedGraph;
begin
  PrintHeader('Test Degrees');
  initialize(g);
  
  add_node(g, 'A');
  add_node(g, 'B');
  add_node(g, 'C');
  add_node(g, 'D');
  
  add_edge(g, 'A', 'B', 5);
  add_edge(g, 'A', 'C', 3);
  add_edge(g, 'B', 'C', 2);
  add_edge(g, 'D', 'A', 4);
  
  writeln('Node A - degree: ', degree(g, 'A'));
  writeln('Node B - degree: ', degree(g, 'B'));
  writeln('Node C - degree: ', degree(g, 'C'));
  writeln('Node D - degree: ', degree(g, 'D'));

  if (degree(g, 'A') = 3) and (degree(g, 'B') = 2) and
     (degree(g, 'C') = 2) and (degree(g, 'D') = 1) then
    writeln('PASSED: Degree function works correctly')
  else
    writeln('FAILED: Issue with degree function');
  

end;

procedure TestDeleteEdgeAndNode();
var
  g: edgeWeightedGraph;
begin
  PrintHeader('Test Delete Edge and Node');
  initialize(g);
  
  add_node(g, 'A');
  add_node(g, 'B');
  add_node(g, 'C');
  
  add_edge(g, 'A', 'B', 5);
  add_edge(g, 'B', 'C', 10);
  add_edge(g, 'C', 'A', 7);
  
  writeln('Graph before deletions:');
  show(g);
  
  writeln('Deleting edge B->C');
  delete_edge(g, 'B', 'C');
  writeln('Edge B->C exists? ', edge_in_graph(g, 'B', 'C'));
  
  writeln('Deleting node B');
  delete_node(g, 'B');
  writeln('Node B exists? ', node_in_graph(g, 'B'));
  writeln('Number of nodes after deletion: ', num_nodes(g));
  
  writeln('Graph after deletions:');
  show(g);
  
  if (not edge_in_graph(g, 'B', 'C')) and (not node_in_graph(g, 'B')) and (num_nodes(g) = 2) then
    writeln('PASSED: Delete functions work correctly')
  else
    writeln('FAILED: Issue with delete functions');
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
  TestDeleteEdgeAndNode();
  
  writeln;
  writeln('All tests completed.');
  writeln('Press Enter to exit...');
  readln;
end.