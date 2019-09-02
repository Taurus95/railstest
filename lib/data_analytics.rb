class Graph
  attr_reader :graph, :nodes, :previous, :distance
  INFINITY = 1 << 64

  def initialize
    @graph = {}
    @nodes = Array.new
  end

  def connect_graph(source, target, weight)
    if (!graph.has_key?(source))
      graph[source] = {target => weight}
    else
      graph[source][target] = weight
    end
    if (!nodes.include?(source))
      nodes << source
    end
  end

  def add_edge(source, target, weight)
    connect_graph(source, target, weight)
    connect_graph(target, source, weight)
  end


  def dijkstra(source)

    distances = {}
    definitivo = ""
    actual = source
    recorridos = {}

    nodes.each do |n|
        recorridos[n] = false
    end

    #encuentro la distancia a cada nodo desde el source
    nodes.each do |n|
        distances[n] = distances self.shortest_paths()
    end

    return distances

  end

  #
  #Return nodos adyacentes
  #
  def adyacente(nodo)
    adyacentes = Array.new
    @graph[nodo].each do |n|
        adyacentes << n[0]
    end
    return adyacentes
  end

  def find_path(dest)
    if @previous[dest] != -1
      find_path @previous[dest]
    end
    @path << dest
  end

  def shortest_paths(source)
      return nil
  end

end

if __FILE__ == $0
  gr = Graph.new
  gr.add_edge("a", "c", 7)
  gr.add_edge("a", "e", 14)
  gr.add_edge("a", "f", 9)
  gr.add_edge("c", "d", 15)
  gr.add_edge("c", "f", 10)
  gr.add_edge("d", "f", 11)
  gr.add_edge("d", "b", 6)
  gr.add_edge("f", "e", 2)
  gr.add_edge("e", "b", 9)
  gr.shortest_paths("a")
  gr.print_result

end
