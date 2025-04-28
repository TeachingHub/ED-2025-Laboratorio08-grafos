unit uListEdgeWeightedGraph;

interface

  uses sysutils;

  type
    edgeWeightedGraph = record

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


end.







