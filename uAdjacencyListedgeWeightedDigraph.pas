unit uAdjacencyListedgeWeightedDigraph;

interface

//  uses TElemento;
  uses sysutils;

  type

    tAdjacencyNode = record
       nodeTo_label, weight: string;
       next: ^tadjacencyNode;
    end;

    tNode = record
       node_label: string;
//       info: TElemento;
       adjacents: ^tAdjacencyNode;
       next: ^tNode
    end;

    edgeWeightedDigraph = ^tNode;

  procedure initialize(var g: edgeWeightedDigraph);
  function  is_empty(g: edgeWeightedDigraph): boolean;

  procedure add_node(var g: edgeWeightedDigraph; _label:string);
  procedure add_edge(var g: edgeWeightedDigraph; n1,n2,weight: string);
  function  get_node(g: edgeWeightedDigraph; _label:string): edgeWeightedDigraph;
  procedure delete_node(var g: edgeWeightedDigraph; node_label:string);
  procedure delete_edge(var g: edgeWeightedDigraph; n1_label,n2_label:string);

  function node_in_graph(g: edgeWeightedDigraph; _label: string): boolean;
  function edge_in_graph(g: edgeWeightedDigraph; n1,n2:string): boolean;

  // Additional methods
  procedure show(g: edgeWeightedDigraph);

  // Ejercicio 3.1
  function  indegree(g:edgeWeightedDigraph; node_label:string): integer;

  // Ejercicio 3.2
  function  outdegree(g:edgeWeightedDigraph; node_label:string): integer;

  // Ejercicio 3.3
  function  slack_outdegree(g:edgeWeightedDigraph):integer;

  // Ejercicio 3.4
  function  weighted_indegree(g: edgeWeightedDigraph; node_label:string): integer;

implementation

  procedure initialize(var g: edgeWeightedDigraph);
  begin
    g:= NIL
  end;

  function is_empty(g: edgeWeightedDigraph): boolean;
  begin
    is_empty:= g=NIL
  end;

  function get_node(g: edgeWeightedDigraph; _label:string): edgeWeightedDigraph;
  begin
      get_node:= g;
      while (get_node<>NIL) and (get_node^.node_label<>_label) do
        get_node:= get_node^.next;
  end;

  function node_in_graph(g: edgeWeightedDigraph; _label: string): boolean;
  begin
      node_in_graph:= get_node(g,_label)<>NIL
  end;

  function edge_in_graph(g: edgeWeightedDigraph; n1,n2: string): boolean;
  var origen: ^tNode;
      destino: ^tAdjacencyNode;
  begin
      origen:= get_node(g,n1);
      if origen=NIL then edge_in_graph:= FALSE
      else begin
        destino:= origen^.adjacents;
        while (destino<>NIL) and (destino^.nodeTo_label<>n2) do
          destino:= destino^.next;
        edge_in_graph:= destino<>NIL;
      end
  end;

  procedure add_node(var g: edgeWeightedDigraph; _label:string{; _info: TElemento});
  var new_node:^tNode;
  begin
    if not node_in_graph(g,_label) then begin
      new(new_node);
      new_node^.node_label:=_label;
      //assign(new_node^.info,_info);
      new_node^.adjacents:=NIL;
      new_node^.next:=g;
      g:= new_node;
    end;
  end;

  procedure add_edge(var g: edgeWeightedDigraph; n1,n2,weight: string);
  var
    origen, destino: ^tNode;
    adj_node: ^tAdjacencyNode;
  begin
    origen:= get_node(g,n1);
    destino:= get_node(g,n2);
    if (origen <> NIL) and (destino <> NIL) then begin
      new(adj_node);
      adj_node^.nodeTo_label:= n2;
      adj_node^.weight:= weight;
      adj_node^.next:= origen^.adjacents;
      origen^.adjacents:= adj_node;
    end;
  end;

  procedure delete_adjacent_list(var g: edgeWeightedDigraph; origen:edgeWeightedDigraph);
  // Internal procedure to dispose all adjacents of a node
  var aux,ant: ^tAdjacencyNode;
  begin
    if origen<>NIL then begin
       aux:= origen^.adjacents;
       while aux<>NIL do begin
         ant:= aux;
         aux:= aux^.next;
         dispose(ant);
       end;
       origen^.adjacents:= NIL;
    end;
  end;

  procedure delete_adjacent_node(var g: edgeWeightedDigraph; origen:edgeWeightedDigraph; toRemoveNode:string);
  // Internal procedure to dispose an edge from an adjacent of a node
  var aux,ant: ^tAdjacencyNode;
  begin
    if origen<>NIL then begin
       aux:= origen^.adjacents;
       while (aux<>NIL) and (aux^.nodeTo_label <> toRemoveNode) do begin
         ant:= aux;
         aux:= aux^.next;
       end;
       if aux<> NIL then begin   // Si había algún arco a toRemoveNode eliminarlo
          if aux=origen^.adjacents then // el nodo a borrar es el primero en la lista de adyacentes
            origen^.adjacents:= aux^.next
          else
            ant^.next:= aux^.next;
          dispose(aux);
       end;
    end;
  end;

  procedure delete_node(var g: edgeWeightedDigraph; node_label:string);
  var nodo_a_borrar, aux: ^tNode;
  begin
    nodo_a_borrar:= get_node(g,node_label);
    if (nodo_a_borrar <> NIL) then begin
       // borrar toda su lista de adyacencia
       delete_adjacent_list(g,nodo_a_borrar);
       // borrar el nodo
       if g=nodo_a_borrar then // borrar el primer nodo de la lista
          g:= nodo_a_borrar^.next
       else begin // el nodo a borrar no es el primero de la lista de adyacencia
          aux:= g;
          while aux^.next<>nodo_a_borrar do
            aux:= aux^.next;
          aux^.next:= nodo_a_borrar^.next
       end;
       dispose(nodo_a_borrar);
       // borrar arcos con este nodo en otras listas de adyacencia
       aux:= g;
       while aux<>NIL do begin
         delete_adjacent_node(g,aux,node_label);
         aux:= aux^.next;
       end;
    end;
  end;

  procedure delete_edge(var g: edgeWeightedDigraph; n1_label,n2_label:string);
  var origen: ^tNode;
      aux,ant: ^tAdjacencyNode;
  begin
      if edge_in_graph(g,n1_label,n2_label) then begin
        origen:= get_node(g,n1_label);
        aux:= origen^.adjacents;
        while aux^.nodeTo_label<>n2_label do begin
          ant:=aux;
          aux:=aux^.next;
        end;
        if aux=ant then origen^.adjacents:= aux^.next
        else ant^.next:= aux^.next;
        dispose(aux);
      end
  end;

  
  
  procedure show(g: edgeWeightedDigraph);
  var nodo: ^tNode;
      nodo_ady: ^tAdjacencyNode;
  begin
    nodo:=g;
    while nodo<>NIL do begin
      write(nodo^.node_label,' -> ');
      nodo_ady:= nodo^.adjacents;
      while nodo_ady<>NIL do begin
        write(nodo_ady^.nodeTo_label, '(',nodo_ady^.weight, ') , ');
        nodo_ady:= nodo_ady^.next
      end;
      writeln('/');
      nodo:= nodo^.next
    end;
  end;






  
  { Ejercicio 3.1}
  { El grado de entrada de un nodo es la cantidad de arcos que llegan a él.}
  function indegree(g:edgeWeightedDigraph; node_label:string): integer;
  begin
    writeln('No implementado');
  end;

  { Ejercicio 3.2}
  { El outdegree de un nodo es la cantidad de arcos que salen de él.}
  function outdegree(g:edgeWeightedDigraph; node_label:string): integer;
  begin
    writeln('No implementado');
  end;



  { Ejercicio 3.3}
  { El slack outdegree es la diferencia entre el máximo y el mínimo de los outdegree de los nodos del grafo.}
  { Se asume que el grafo no está vacío.} 
  function slack_outdegree(g:edgeWeightedDigraph):integer;
  begin
    writeln('No implementado');
  end;

  
  { Ejercicio 3.4}
  { El grado de salida de un nodo es la cantidad de arcos que salen de él.}
  function weighted_indegree(g: edgeWeightedDigraph; node_label:string): integer;
  begin
    writeln('No implementado');
  end;

end.























