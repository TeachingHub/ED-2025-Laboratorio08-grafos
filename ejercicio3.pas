program TestAdjacencyListEdgeWeightedDigraph;

uses
  uAdjacencyListedgeWeightedDigraph, sysutils;

var
  grafo: edgeWeightedDigraph;
  opcion: integer;
  nodo1, nodo2, peso: string;

procedure CrearGrafoEjemplo(var g: edgeWeightedDigraph);
begin
  // Inicializar el grafo
  initialize(g);
  
  // Agregar nodos
  add_node(g, 'A');
  add_node(g, 'B');
  add_node(g, 'C');
  add_node(g, 'D');
  add_node(g, 'E');
  
  // Agregar aristas con pesos
  add_edge(g, 'A', 'B', '5');
  add_edge(g, 'A', 'C', '3');
  add_edge(g, 'B', 'C', '2');
  add_edge(g, 'B', 'D', '1');
  add_edge(g, 'C', 'D', '7');
  add_edge(g, 'D', 'E', '4');
  add_edge(g, 'E', 'A', '6');
  
  writeln('Grafo de ejemplo creado con éxito.');
end;

procedure MostrarMenu;
begin
  writeln;
  writeln('=== MENÚ DE PRUEBA DEL GRAFO DIRIGIDO PONDERADO ===');
  writeln('1. Crear grafo de ejemplo');
  writeln('2. Mostrar grafo');
  writeln('3. Agregar nodo');
  writeln('4. Agregar arista con peso');
  writeln('5. Eliminar nodo');
  writeln('6. Eliminar arista');
  writeln('7. Verificar si existe un nodo');
  writeln('8. Verificar si existe una arista');
  writeln('9. Calcular grado de entrada de un nodo');
  writeln('10. Calcular grado de salida de un nodo');
  writeln('11. Calcular grado de entrada ponderado de un nodo');
  writeln('12. Calcular slack del grado de salida');
  writeln('0. Salir');
  write('Ingrese su opción: ');
end;

begin
  // Inicializar el grafo
  initialize(grafo);
  
  repeat
    MostrarMenu;
    readln(opcion);
    
    case opcion of
      1: CrearGrafoEjemplo(grafo);
      
      2: begin
         writeln('Estructura del grafo:');
         show(grafo);
         end;
      
      3: begin
         write('Ingrese el nombre del nodo a agregar: ');
         readln(nodo1);
         add_node(grafo, nodo1);
         writeln('Nodo "', nodo1, '" agregado correctamente.');
         end;
      
      4: begin
         write('Ingrese el nodo origen: ');
         readln(nodo1);
         write('Ingrese el nodo destino: ');
         readln(nodo2);
         write('Ingrese el peso de la arista: ');
         readln(peso);
         
         if not node_in_graph(grafo, nodo1) then
           writeln('Error: El nodo origen "', nodo1, '" no existe en el grafo.')
         else if not node_in_graph(grafo, nodo2) then
           writeln('Error: El nodo destino "', nodo2, '" no existe en el grafo.')
         else begin
           add_edge(grafo, nodo1, nodo2, peso);
           writeln('Arista desde "', nodo1, '" hacia "', nodo2, '" con peso ', peso, ' agregada correctamente.');
         end;
         end;
      
      5: begin
         write('Ingrese el nodo a eliminar: ');
         readln(nodo1);
         
         if not node_in_graph(grafo, nodo1) then
           writeln('Error: El nodo "', nodo1, '" no existe en el grafo.')
         else begin
           delete_node(grafo, nodo1);
           writeln('Nodo "', nodo1, '" eliminado correctamente junto con todas sus aristas asociadas.');
         end;
         end;
      
      6: begin
         write('Ingrese el nodo origen de la arista a eliminar: ');
         readln(nodo1);
         write('Ingrese el nodo destino de la arista a eliminar: ');
         readln(nodo2);
         
         if not edge_in_graph(grafo, nodo1, nodo2) then
           writeln('Error: No existe una arista desde "', nodo1, '" hacia "', nodo2, '".')
         else begin
           delete_edge(grafo, nodo1, nodo2);
           writeln('Arista desde "', nodo1, '" hacia "', nodo2, '" eliminada correctamente.');
         end;
         end;
      
      7: begin
         write('Ingrese el nodo a verificar: ');
         readln(nodo1);
         
         if node_in_graph(grafo, nodo1) then
           writeln('El nodo "', nodo1, '" SÍ existe en el grafo.')
         else
           writeln('El nodo "', nodo1, '" NO existe en el grafo.');
         end;
      
      8: begin
         write('Ingrese el nodo origen: ');
         readln(nodo1);
         write('Ingrese el nodo destino: ');
         readln(nodo2);
         
         if edge_in_graph(grafo, nodo1, nodo2) then
           writeln('La arista desde "', nodo1, '" hacia "', nodo2, '" SÍ existe en el grafo.')
         else
           writeln('La arista desde "', nodo1, '" hacia "', nodo2, '" NO existe en el grafo.');
         end;
      
      9: begin
         write('Ingrese el nodo para calcular su grado de entrada: ');
         readln(nodo1);
         
         if not node_in_graph(grafo, nodo1) then
           writeln('Error: El nodo "', nodo1, '" no existe en el grafo.')
         else
           writeln('El grado de entrada del nodo "', nodo1, '" es: ', indegree(grafo, nodo1));
         end;
      
      10: begin
          write('Ingrese el nodo para calcular su grado de salida: ');
          readln(nodo1);
          
          if not node_in_graph(grafo, nodo1) then
            writeln('Error: El nodo "', nodo1, '" no existe en el grafo.')
          else
            writeln('El grado de salida del nodo "', nodo1, '" es: ', outdegree(grafo, nodo1));
          end;
      
      11: begin
          write('Ingrese el nodo para calcular su grado de entrada ponderado: ');
          readln(nodo1);
          
          if not node_in_graph(grafo, nodo1) then
            writeln('Error: El nodo "', nodo1, '" no existe en el grafo.')
          else
            writeln('El grado de entrada ponderado del nodo "', nodo1, '" es: ', weighted_indegree(grafo, nodo1));
          end;
      
      12: begin
          if is_empty(grafo) then
            writeln('El grafo está vacío, no se puede calcular el slack.')
          else
            writeln('El slack del grado de salida del grafo es: ', slack_outdegree(grafo));
          end;
      
      0: writeln('Saliendo del programa...');
      
      else
        writeln('Opción no válida. Intente de nuevo.');
    end;
    
    if opcion <> 0 then begin
      writeln;
      write('Presione Enter para continuar...');
      readln;
    end;
    
  until opcion = 0;
end.