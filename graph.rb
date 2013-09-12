class Graph < Array
  attr_reader :edges
  
  def initialize(links, station_time=1, transfer_time=1)
    @station_time, @transfer_time = station_time, transfer_time
    @edges = []
    @neighbors = {}
    @vertices = links.nodes

    links.each do |link|
      connect_mutually(link.node1, link.node2)
    end

    @distances = {}
    @routes = {}
    @vertices.each do |vertex|
      routes_for(vertex)
    end
  end
  
  def length_between(src, dst)
    @edges.each do |edge|
      return edge.length if edge.src == src and edge.dst == dst
    end
    nil
  end
 
  def route(src, dst)
    @routes[[src, dst]]
  end
  def routes
    @routes.values.reject {|route| route.nil? || route.stations.length <= 1}
  end
  def routes_by_transer
    @routes.each_with_object([]) do |route, routes| 
      transfer = route.lines.length - 1;
      routes[transfer] = 0 if routes[transfer].nil?
      routes[transfer] += 1
    end
  end
  def max_transfer_times
    @routes.values.collect{|route| route.lines.length-1}.max
  end
  private
  def connect_mutually(src, dst, length = 2.5)
    connect(src, dst, length)
    connect(dst, src, length)
  end
  def connect(src, dst, length)
    @edges.push Edge.new(dst, src, length)
    @neighbors[src] ||= [] 
    @neighbors[src] << dst
  end

  def routes_for(src)
    @vertices.each do |vertex|
      @distances[[src, vertex]] = nil # Infinity
      @routes[[src, vertex]] = Route.new [src], @station_time, @transfer_time
    end
    @distances[[src, src]] = 0
    vertices = @vertices.clone

    until vertices.empty?
      nearest_vertex = vertices.inject do |a, b|
        next b unless @distances[[src, a]] 
        next a unless @distances[[src, b]]
        next a if @distances[[src, a]] < @distances[[src, b]]
        b
      end
      # p "--------nearest_vertex: #{src}, #{nearest_vertex}"
      break unless @distances[[src, nearest_vertex]] # Infinity
      break unless @neighbors[[src, nearest_vertex]] # Infinity
      neighbors = @neighbors[nearest_vertex]
      # p "nearest_vertex: #{nearest_vertex}, distances[#{src}][#{nearest_vertex}]: #{@distances[src][nearest_vertex]},neighbors: #{neighbors}"
      neighbors.each do |vertex|
        # alt = @distances[[src, nearest_vertex]] + self.length_between(nearest_vertex, vertex)
        newRoute =Route.new(@routes[[src, nearest_vertex]].stations + [vertex], @station_time, @transfer_time)
        # p "vertex: #{vertex}, vertices.length_between(#{nearest_vertex}, #{vertex}): #{vertices.length_between(nearest_vertex, vertex)}, alt: #{alt}"
        if @distances[[src, vertex]].nil? || newRoute.total_time < @distances[[src, vertex]]
          @distances[[src, vertex]] = newRoute.total_time 
          @routes[[src, vertex]] = newRoute
        end
      end
      vertices.delete nearest_vertex
    end
  end
end

class Edge
  attr_accessor :src, :dst, :length
  
  def initialize(src, dst, length=2.5)
    @src = src
    @dst = dst
    @length = length
  end
end

class Route
  attr_reader :stations
  def initialize(stations, station_time=150, transfer_time=191)
    @stations, @station_time, @transfer_time = stations, station_time, transfer_time
    # @line_stations = calculate_line_stations(stations)
  end
  def total_time
    (@line_stations.length - 1) * @station_time + (lines.length - 1) * @transfer_time
  end
  def lines
    @line_stations.collect{|line_station| line_station.line}.uniq
  end
  def transfer_stations
    previous_line = nil
    previous_station = nil
    @line_stations.each_with_object([]) do |line_station, stations|
      if !previous_line.nil? && line_station.line != previous_line
        previous_line = line_station.line
        stations << previous_station 
      end
      previous_line, previous_station = line_station.line, line_station.station
    end
  end
  def ==(other)
    return false if @stations.length != other.stations.length
    @stations.each_with_index do |station, i|
      return false if station != other.stations[i]
    end
    return true
  end
end