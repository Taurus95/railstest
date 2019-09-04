# frozen_string_literal: true

class Graph
    attr_reader :graph, :nodes, :previous, :distance
    INFINITY = 1 << 64

    def initialize
        @graph = {}
        @nodes = []
        @distance = {}
        @previous = {}
    end

    def connect_graph(source, target, weight)
        if !graph.key?(source)
            graph[source] = { target => weight }
        else
            graph[source][target] = weight
        end
        nodes << source unless nodes.include?(source)
    end

    def add_edge(source, target, weight)
        connect_graph(source, target, weight)
        connect_graph(target, source, weight)
    end

    def dijkstra(source)
        position = source
        acumulada = 0
        final = {}
        temporal = {}
        analisados = {}

        nodes.each do |n|
            final[n] = nil
            temporal[n] = INFINITY
            analisados[n] = false
        end

        if position == source
            final[position] = 0
            temporal[position] = 0
            acumulada = 0
        end

        while analisados(analisados)
            adyacentes(position, analisados).each do |n|
                if temporal[n] > graph[position][n] + acumulada
                    temporal[n] = graph[position][n] + acumulada
                end
            end
            analisados[position] = true
            position = menorTemporal(temporal, analisados)
            acumulada = temporal[position]
            final[position] = temporal[position] unless temporal[position].nil?

        end
        @distance = final
        shortest_paths('d')
    end

    #
    # Return nodos adyacentes disponibles
    #
    def adyacentes(nodo, analisados)
        adyacentes = []
        @graph[nodo].each do |n|
            adyacentes << n[0] if analisados[n[0]] == false
        end
        adyacentes
    end

    #
    # Return boolean if there is a no analisado
    #
    def analisados(analisados)
        analisados.each do |_n, value|
            return true if value == false
        end
        false
    end

    #
    # Return boolean
    #
    def analisado(nodo, analisados)
        analisados.each do |n, value|
            return true if nodo == n && value == true
        end
        false
    end

    #
    # Return boolean if there is a no analisado
    #
    def menorTemporal(temporal, analisados)
        menor = INFINITY
        letra = ''
        temporal.each do |n, value|
            if value < menor && !value.nil? && !analisado(n, analisados)
                letra = n
            end
        end
        letra
    end

    #
    # Set the previous variable and return the shortest path from "a" to dest
    #
    def shortest_paths(dest)
        position = dest
        final = {}
        analisados = {}
        route = []
        route << dest
        @previous['a'] = -1

        @nodes.each do |n|
            analisados[n] = false
        end
        analisados[position] = true

        while analisados(analisados)
            adyacentes(position, analisados).each do |n|
                if @distance[n] == (@distance[position] - graph[n][position])
                    @previous[position] = n
                    position = n
                    route << n
                end
                analisados[n] = true
            end

        end
        route << 'a'
        route
    end
end

if $PROGRAM_NAME == __FILE__
    gr = Graph.new
    gr.add_edge('a', 'c', 7)
    gr.add_edge('a', 'e', 14)
    gr.add_edge('a', 'f', 9)
    gr.add_edge('c', 'd', 15)
    gr.add_edge('c', 'f', 10)
    gr.add_edge('d', 'f', 11)
    gr.add_edge('d', 'b', 6)
    gr.add_edge('f', 'e', 2)
    gr.add_edge('e', 'b', 9)
    gr.shortest_paths('a')
    gr.print_result

end
