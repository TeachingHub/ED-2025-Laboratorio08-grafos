unit uListOfAdjacents;

interface

uses
    SysUtils;

type
    nodo = record
        info: String; // Información almacenada en el nodo
        weight: integer;
        sig: ^nodo; // Puntero al siguiente nodo
    end;

    tListOfAdjacents = record
        first, last: ^nodo; // Punteros al primer y último nodo de la lista
    end;

    {Operaciones básicas}
    procedure initialize(var list: tListOfAdjacents);
    function is_empty(list: tListOfAdjacents): boolean;
    function first(list: tListOfAdjacents): string;
    function last(list: tListOfAdjacents): string;
    procedure insert_at_end(var list: tListOfAdjacents; x: string; weight: integer);
    procedure delete(var list: tListOfAdjacents; x: string);
    function in_list(list: tListOfAdjacents; x: string): boolean;

    {Otras operaciones}
    function to_string(list: tListOfAdjacents): string;
    procedure clear(var list: tListOfAdjacents);
    function num_elems(list: tListOfAdjacents): integer;
    procedure copy(list: tListOfAdjacents; var c2: tListOfAdjacents);

    {Nuevas funciones para trabajar con grafos}
    function get_weight(list: tListOfAdjacents; x: String): integer;

implementation

    procedure initialize(var list: tListOfAdjacents);
    begin
        list.first := nil; // Inicializa la lista vacía
        list.last := nil; // Inicializa la lista vacía
    end;

    function is_empty(list: tListOfAdjacents): boolean;
    begin
        is_empty := list.first = nil; // Verifica si la lista está vacía
    end;

    function first(list: tListOfAdjacents): string;
    begin
        if not is_empty(list) then
            first := list.first^.info; // Devuelve el primer elemento de la lista
    end;

    function last(list: tListOfAdjacents): string;
    begin
        if not is_empty(list) then
            last := list.last^.info; // Devuelve el último elemento de la lista
    end;

    procedure insert_at_end(var list: tListOfAdjacents; x: string; weight: integer);
    var
        newNode: ^nodo;
    begin
        new(newNode); // Crea un nuevo nodo
        newNode^.info := x; // Asigna el valor al nuevo nodo
        newNode^.sig := nil; // El siguiente nodo es nil porque es el último
        newNode^.weight := weight;
        if is_empty(list) then
            list.first := newNode // Si la lista está vacía, el nuevo nodo es el primero
        else
            list.last^.sig := newNode; // Si no, se enlaza al final de la lista
        list.last := newNode; // Actualiza el último nodo de la lista
    end;

    procedure delete(var list: tListOfAdjacents; x: string);
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
            if prev = nil then // Si el nodo a eliminar es el primero
                list.first := current^.sig
            else // Si el nodo a eliminar no es el primero
                prev^.sig := current^.sig;
            if current = list.last then // Si el nodo a eliminar es el último
                list.last := prev;
            dispose(current); // Libera el nodo
        end;
    end;

    function in_list(list: tListOfAdjacents; x: string): boolean;
    var
        current: ^nodo;
    begin
        current := list.first;
        while (current <> nil) and (current^.info <> x) do
            current := current^.sig;
        in_list := current <> nil; // Devuelve true si se encontró el elemento
    end;

    function to_string(list: tListOfAdjacents): string;
    var
        current: ^nodo;
        str: string;
    begin
        str := '';
        current := list.first;
        while current <> nil do
        begin
            str := str + (current^.info)+ '(' + IntToStr(current^.weight) +')' + ' '; // Concatenar el valor del nodo a la cadena
            current := current^.sig;
        end;
        to_string := str; // Devuelve la representación en cadena de la lista
    end;

    procedure clear(var list: tListOfAdjacents);
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

    function num_elems(list: tListOfAdjacents): integer;
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

    procedure copy(list: tListOfAdjacents; var c2: tListOfAdjacents);
    var
        current: ^nodo;
    begin
        initialize(c2); // Inicializa la lista de destino
        current := list.first;
        while current <> nil do
        begin
            insert_at_end(c2, current^.info, current^.weight); // Inserta cada elemento en la lista de destino
            current := current^.sig;
        end;
    end;

function get_weight(list: tListOfAdjacents; x: String): integer;
    var
        current: ^nodo;
    begin
        current := list.first;
        while (current <> nil) and (current^.info <> x) do
            current := current^.sig;
        if current <> nil then
            get_weight := current^.weight;
    end;


end.
