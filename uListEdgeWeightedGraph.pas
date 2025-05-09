unit uListEdgeWeightedGraph;

interface
  uses sysutils, uListOfNodes, uListOfAdjacents;

  type
    edgeWeightedGraph = record
       list_of_nodes :   tLisfNodes;
    end;

  { -- FUNCIONES DE MANIPULACION DEL GRAFO -- }
  
  { Inicializar el grafo }
  { Inicializa el grafo vacío, configurando la matriz de adyacencia con valores 'inf' 
    y estableciendo el número de nodos en 0. }
  procedure initialize(var g: edgeWeightedGraph);

  { Agregar un nodo al grafo }
  { Agrega un nodo al grafo si no existe ya y si no se ha alcanzado el límite máximo de nodos. }
  procedure add_node(var g: edgeWeightedGraph; node: string);

  { Agregar un arco al grafo }
  { Agrega un arco dirigido entre dos nodos existentes en el grafo con un peso especificado. }
  procedure add_edge(var g: edgeWeightedGraph; n1, n2: string; weight: integer);

  { Eliminar un nodo del grafo }
  { Elimina un nodo del grafo, ajustando la matriz de adyacencia y las etiquetas de los nodos. }
  procedure delete_node(var g: edgeWeightedGraph; node: string);

  { Eliminar un arco del grafo }
  { Elimina un arco dirigido entre dos nodos existentes en el grafo. }
  procedure delete_edge(var g: edgeWeightedGraph; n1, n2: string);

  { -- FUNCIONES DE CONSULTA DEL GRAFO -- }

  {Determina el número de nodos en el grafo}
  { Devuelve el número de nodos en el grafo. }
  function num_nodes(g: edgeWeightedGraph): integer;

  { Determina si el grafo está vacío }
  { Devuelve true si el grafo no tiene nodos, false en caso contrario. }
  function is_empty(g: edgeWeightedGraph): boolean;

  { Determina si un nodo está en el grafo }
  { Devuelve true si el nodo especificado existe en el grafo, false en caso contrario. }
  function node_in_graph(g: edgeWeightedGraph; node: string): boolean;

  { Determina si un arco está en el grafo }
  { Devuelve true si existe un arco dirigido entre los nodos especificados, false en caso contrario. }
  function edge_in_graph(g: edgeWeightedGraph; n1, n2: string): boolean;

  { Determina si un arco está en el grafo y retorna su peso }
  { Devuelve el peso del arco dirigido entre los nodos especificados, o 0 si no existe. }
  function edge_weight(g: edgeWeightedGraph; n1, n2: string): integer;

  { Determina si dos nodos son adyacentes }
  { Devuelve true si existe un arco dirigido entre los nodos especificados, false en caso contrario. }
  function adjacent(g: edgeWeightedGraph; n1, n2: string): boolean;

  { Calcula el grado total de un nodo }
  { Devuelve la suma de los grados de entrada y salida del nodo especificado. }
  function degree(var g: edgeWeightedGraph; node: string): integer;

  { ---------- FUNCIONES DE VISUALIZACION ---------- }


  { Muestra el grafo en la consola }
  procedure show(g: edgeWeightedGraph);


implementation

  { Inicializa el grafo vacío }
  procedure initialize(var g: edgeWeightedGraph);
  begin
    uListOfNodes.initialize(g.list_of_nodes); // Inicializa la lista de adyacentes
  end;

  { Agrega un nodo al grafo }
  procedure add_node(var g: edgeWeightedGraph; node: string);
  begin
    if not node_in_graph(g, node) then
    begin
      uListOfNodes.insert_at_end(g.list_of_nodes, node); // Agrega el nodo a la lista de adyacentes
    end;
  end;

  { Agrega un arco al grafo }
  procedure add_edge(var g: edgeWeightedGraph; n1, n2: string; weight: integer);
  var
    list_of_nodes : tLisfNodes;
  begin
    list_of_nodes := g.list_of_nodes;
    if (node_in_graph(g, n1)) and (node_in_graph(g, n2) and (not edge_in_graph(g, n1, n2))) then
        add_adjacent(list_of_nodes, n1, n2, weight); // Agrega el arco entre los nodos
        add_adjacent(list_of_nodes, n2, n1, weight); // Agrega el arco inverso si es un grafo no dirigido
  end;

  { Elimina un nodo del grafo }
  procedure delete_node(var g: edgeWeightedGraph; node: string);
  var
    list_of_nodes : tLisfNodes;
  begin
    list_of_nodes := g.list_of_nodes;
    if node_in_graph(g, node) then
        uListOfNodes.delete(list_of_nodes, node);
  end;

  procedure delete_edge(var g: edgeWeightedGraph; n1, n2: string);
  var
    list_of_nodes : tLisfNodes;
  begin
    list_of_nodes := g.list_of_nodes;
    if (node_in_graph(g, n1)) and (node_in_graph(g, n2)) then
    begin
        uListOfNodes.delete_edge(list_of_nodes, n1, n2);
        uListOfNodes.delete_edge(list_of_nodes, n2, n1); // Elimina el arco inverso si es un grafo no dirigido
    end;
  end;


  function is_empty(g: edgeWeightedGraph): boolean;
  var
    list_of_nodes : tLisfNodes;
  begin
    list_of_nodes := g.list_of_nodes;
    is_empty := uListOfNodes.num_elems(list_of_nodes) = 0;
  end;  

  function num_nodes(g: edgeWeightedGraph): integer;
  var
    list_of_nodes : tLisfNodes;
  begin
    list_of_nodes := g.list_of_nodes;
    num_nodes := uListOfNodes.num_elems(list_of_nodes); // Devuelve el número de nodos en la lista
  end;
  
  function node_in_graph(g: edgeWeightedGraph; node: string): boolean;
  var
    list_of_nodes : tLisfNodes;
  begin
    list_of_nodes := g.list_of_nodes;
    node_in_graph := uListOfNodes.in_list(list_of_nodes, node); // Verifica si el nodo está en la lista
  end;


  function edge_in_graph(g: edgeWeightedGraph; n1, n2: string): boolean;
  var
    list_of_nodes : tLisfNodes;
  begin
    list_of_nodes := g.list_of_nodes;
    edge_in_graph := uListOfNodes.is_adjacent(list_of_nodes, n1, n2); // Verifica si el arco está en la lista
  end;


  function edge_weight(g: edgeWeightedGraph; n1, n2: string): integer;
  var
    list_of_nodes : tLisfNodes;
  begin
    list_of_nodes := g.list_of_nodes;
    if edge_in_graph(g, n1, n2) then
      edge_weight := uListOfNodes.get_weight(list_of_nodes, n1, n2) // Obtiene el peso del arco
    else
      edge_weight := 0; // Si no existe el arco, devuelve 0
  end;

  function adjacent(g: edgeWeightedGraph; n1, n2: string): boolean;
  begin
    adjacent := edge_in_graph(g, n1, n2); // Verifica si los nodos son adyacentes
  end;  

  function degree(var g: edgeWeightedGraph; node: string): integer;
  var
    list_of_nodes : tLisfNodes;
  begin
    list_of_nodes := g.list_of_nodes;
    degree := uListOfNodes.get_degree(list_of_nodes, node); // Obtiene el grado del nodo
  end;

  procedure show(g: edgeWeightedGraph);
  begin
    writeln(uListOfNodes.to_string(g.list_of_nodes)); // Muestra la lista de nodos
  end;

end.







