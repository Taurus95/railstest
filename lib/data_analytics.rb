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
    @distance={}
    @previous={}
    nodes.each do |nodo|
      @distance[nodo] = INFINITY
      @previous[nodo] = -1
    end

    @distance[source] = 0 #Distance from point to point

    missing_node = nodes.compact #nil elements removed.

    while (missing_node.size > 0)
      elementNull = nil;

      missing_node.each do |min|
        if (not elementNull) or (@distance[min] and @distance[min] < @distance[elementNull])
          elementNull = min
        end
      end

      if (@distance[elementNull] == INFINITY)
        break
      end

      missing_node = missing_node - [elementNull]

      graph[elementNull].keys.each do |vertex|
        alt = @distance[elementNull] + graph[elementNull][vertex]

        if (alt < @distance[vertex])
          @distance[vertex] = alt
          @previous[vertex] = elementNull
        end

      end

    end

  end

  def find_path(dest)
    if @previous[dest] != -1
      find_path @previous[dest]
    end
    @path << dest
  end

  def shortest_paths(source)
    @graph_paths=[]
    @source = source
    dijkstra source
    nodes.each do |dest|
      @path=[]

      find_path dest

      now=if @distance[dest] != INFINITY
                        @distance[dest]
                      else
                        "no path"
                      end
      @graph_paths<< "permanent point(#{dest})  #{@path.join("-->")} : #{now}"
    end
    @graph_paths
  end

  def permanent_point
    return @graph_paths
  end

end


