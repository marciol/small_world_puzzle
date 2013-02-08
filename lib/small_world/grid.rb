module SmallWorld

  class Grid
    attr_accessor :columns, :rows, :to_visit, :visited, :visitor

    def initialize(columns = 100, rows = 100)
      self.columns, self.rows = columns, rows
      self.to_visit = PointCollection.new 
      self.visited = PointCollection.new 
      self.visitor = Point.new(0, 0)
    end

    def self.generate(hsh = {})
      dimensions = { columns: 100, rows: 100 }.merge(hsh)
      instance = new(*dimensions.values_at(:columns, :rows))
      instance.generate!
      instance
    end

    def self.load(hsh = {})
      state = { to_visit: [], visited: [], visitor: [] }.merge(hsh)
      instance = new 
      instance.load_state(*state.values_at(:to_visit, :visited, :visitor))
      instance
    end
    
    def generate!
      self.to_visit = generate
    end

    def load_state(to_visit, visited, visitor)
      self.to_visit = to_visit.map { |(x, y)| SmallWorld::Point.new(x, y) }
      self.visited  =  visited.map { |(x, y)| SmallWorld::Point.new(x, y) }
      self.visitor  =  SmallWorld::Point.new(*visitor.to_a)
    end

    def move_visitor!
      point = to_visit.closest_point_of(visitor)
      visitor.move_in_direction_to(point) if point
    end

    def closest_points_of_visitor
      to_visit.closest_points_of(visitor)
    end

    def remains_any_point_to_visit?
      to_visit.any?
    end

    def to_hash
      { to_visit: to_visit.map(&:to_a), visited: visited.map(&:to_a), visitor: visitor.to_a }
    end

    def to_json(options = {})
      to_hash.to_json
    end
    private

    def generate
      rand(2..10).times.map do
        SmallWorld::Point.new(rand(1..rows), rand(1..columns))
      end
    end
  end
end
