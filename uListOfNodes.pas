unit uListOfNodes;

interface

uses
    SysUtils, uListOfAdjacents;

type
    nodo = record
        info: String; // Información almacenada en el nodo
        adjacents : tListOfAdjacents;
        sig: ^nodo; // Puntero al siguiente nodo
    end;

    tLisfNodes = record
        first, last: ^nodo; // Punteros al primer y último nodo de la lista
    end;

    {Operaciones básicas}
    procedure initialize(var list: tLisfNodes);
    function is_empty(list: tLisfNodes): boolean;
    function first(list: tLisfNodes): string;
    function last(list: tLisfNodes): string;
    procedure insert_at_end(var list: tLisfNodes; x: string);
    procedure delete(var list: tLisfNodes; x: string);
    function in_list(list: tLisfNodes; x: string): boolean;

    {Otras operaciones}
    function to_string(list: tLisfNodes): string;
    procedure clear(var list: tLisfNodes);
    function num_elems(list: tLisfNodes): integer;
    
    {Nuevas funciones para trabajar con grafos}
    procedure get_adjacents(list: tLisfNodes; x: String; var adjacents: tListOfAdjacents);
    function is_adjacent(list: tLisfNodes; x1, x2: String): boolean;
    procedure add_adjacent(var list: tLisfNodes; n1, n2: String; weight: integer);
    procedure delete_edge(var list: tLisfNodes; n1, n2: string);
    function get_weight(list: tLisfNodes; n1, n2: string): integer;
    function get_degree(list: tLisfNodes; x: string): integer;


implementation

    procedure initialize(var list: tLisfNodes);
    begin
        list.first := nil; // Inicializa la lista vacía
        list.last := nil; // Inicializa la lista vacía
    end;

    function is_empty(list: tLisfNodes): boolean;
    begin
        is_empty := list.first = nil; // Verifica si la lista está vacía
    end;

    function first(list: tLisfNodes): string;
    begin
        if not is_empty(list) then
            first := list.first^.info; // Devuelve el primer elemento de la lista
    end;

    function last(list: tLisfNodes): string;
    begin
        if not is_empty(list) then
            last := list.last^.info; // Devuelve el último elemento de la lista
    end;

    procedure insert_at_end(var list: tLisfNodes; x: string);
    var
        newNode: ^nodo;
    begin
        new(newNode); // Crea un nuevo nodo
        newNode^.info := x; // Asigna el valor al nuevo nodo
        newNode^.sig := nil; // El siguiente nodo es nil porque es el último
        uListOfAdjacents.initialize(newNode^.adjacents);
        if is_empty(list) then
            list.first := newNode // Si la lista está vacía, el nuevo nodo es el primero
        else
            list.last^.sig := newNode; // Si no, se enlaza al final de la lista
        list.last := newNode; // Actualiza el último nodo de la lista
    end;

    procedure delete(var list: tLisfNodes; x: string);
    var
        current, prev: ^nodo;
    begin
        current := list.first;
        prev := nil;
        while (current <> nil) and (current^.info <> x) do // Buscar el nodo a eliminar
        begin
            prev := current;
            current := current^.sig;
        end;
        if current <> nil then // Si se encontró el nodo
        begin
            uListOfAdjacents.clear(current^.adjacents);
            if prev = nil then // Si el nodo a eliminar es el primero
                list.first := current^.sig
            else // Si el nodo a eliminar no es el primero
                prev^.sig := current^.sig;
            if current = list.last then // Si el nodo a eliminar es el último
                list.last := prev;
            dispose(current); // Libera el nodo
        end;
        current := list.first;
        while (current <> nil) and (uListOfAdjacents.in_list(current^.adjacents, x)) do
            uListOfAdjacents.delete(current^.adjacents, x);
    end;

    function in_list(list: tLisfNodes; x: string): boolean;
    var
        current: ^nodo;
    begin
        current := list.first;
        while (current <> nil) and (current^.info <> x) do
            current := current^.sig;
        in_list := current <> nil; // Devuelve true si se encontró el elemento
    end;

    function to_string(list: tLisfNodes): string;
    var
        current: ^nodo;
        str: string;
    begin
        str := '';
        current := list.first;
        while current <> nil do
        begin
            str := str + (current^.info)+ '[' + uListOfAdjacents.to_string(current^.adjacents) +']' +  sLineBreak;
            current := current^.sig;
        end;
        to_string := str; // Devuelve la representación en cadena de la lista
    end;

    procedure clear(var list: tLisfNodes);
    var
        temp: ^nodo;
    begin
        while list.first <> nil do
        begin
            temp := list.first;
            list.first := list.first^.sig;
            dispose(temp); // Libera cada nodo
        end;
        list.last := nil; // La lista está vacía
    end;

    function num_elems(list: tLisfNodes): integer;
    var
        current: ^nodo;
        count: integer;
    begin
        count := 0;
        current := list.first;
        while current <> nil do
        begin
            inc(count); // Incrementa el contador por cada nodo
            current := current^.sig;
        end;
        num_elems := count; // Devuelve el número de elementos en la lista
    end;


    procedure get_adjacents(list: tLisfNodes; x: String; var adjacents: tListOfAdjacents);
    var
        current: ^nodo;
    begin
        current := list.first;
        while (current <> nil) and (current^.info <> x) do
            current := current^.sig;
        if current <> nil then
            copy(current^.adjacents, adjacents);
    end;

    procedure add_adjacent(var list: tLisfNodes; n1, n2: String; weight: integer);
    var
        current: ^nodo;
        found: boolean;
    begin
        found := false;
        current := list.first;
        while (current <> nil) and (not found) do
        begin
            if current^.info = n1 then
            begin
                uListOfAdjacents.insert_at_end(current^.adjacents, n2, weight);
                found := true; // Se encontró el nodo  
            end;    
            current := current^.sig;
        end;
    end;

    procedure delete_edge(var list: tLisfNodes; n1, n2: string);
    var
        current: ^nodo;
        found: boolean;
    begin
        found := false;
        current := list.first;
        while (current <> nil) and (not found) do
        begin
            if current^.info = n1 then
            begin
                uListOfAdjacents.delete(current^.adjacents, n2);
                found := true; // Se encontró el nodo
            end;
            current := current^.sig;
        end;
    end;

    function is_adjacent(list: tLisfNodes; x1, x2: String): boolean;
    var
        current: ^nodo;
        found: boolean;
    begin
        found := false;
        current := list.first;
        while (current <> nil) and (not found) do
        begin
            if current^.info = x1 then
            begin
                found := uListOfAdjacents.in_list(current^.adjacents, x2);
            end;
            current := current^.sig;
        end;
        is_adjacent := found; // Devuelve true si se encontró el arco
    end;

    function get_weight(list: tLisfNodes; n1, n2: string): integer;
    var
        current: ^nodo;
        weight: integer;
    begin
        weight := 0;
        current := list.first;
        while (current <> nil) do
        begin
            if current^.info = n1 then
            begin
                weight := uListOfAdjacents.get_weight(current^.adjacents, n2);
                break;
            end;
            current := current^.sig;
        end;
        get_weight := weight; // Devuelve el peso del arco
    end;

    function get_degree(list: tLisfNodes; x: string): integer;
    var
        current: ^nodo;
        degree: integer;
    begin
        degree := 0;
        current := list.first;
        while (current <> nil) do
        begin
            if current^.info = x then
            begin
                degree := uListOfAdjacents.num_elems(current^.adjacents);
                break;
            end;
            current := current^.sig;
        end;
        get_degree := degree; // Devuelve el grado del nodo
    end;


end.
