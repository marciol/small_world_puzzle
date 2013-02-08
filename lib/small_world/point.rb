module SmallWorld
  class Point

    attr_accessor :x, :y

    def initialize(x, y)
      @x, @y = x, y
    end

    def distance_of(point)
      x_section = @x - point.x
      y_section = @y - point.y
      Math.sqrt(x_section ** 2 + y_section ** 2).round(2)
    end

    def to_a
      [@x, @y]
    end

    def move_in_direction_to(point)
      next_on_x = point_crossing_next_grid_line_on_x(point)
      next_on_y = point_crossing_next_grid_line_on_y(point)
      distance_of_next_on_x = self.distance_of(next_on_x)
      distance_of_next_on_y = self.distance_of(next_on_y)
      
      if distance_of_next_on_x < distance_of_next_on_y
        next_on_x
      else
        next_on_y
      end
    end

    private

    def point_crossing_next_grid_line_on_x(point)
      line = Line.new(self, point)
      next_grid_line = nearest_grid_line(self.x, point.x)
      line.point_on_x_axis(next_grid_line)
    end

    def point_crossing_next_grid_line_on_y(point)
      line = Line.new(self, point)
      next_grid_line = nearest_grid_line(self.y, point.y)
      line.point_on_y_axis(next_grid_line)
    end

    def nearest_grid_line(origin, target)
      if target > origin
        (origin + 0.01).ceil
      else
        (origin - 0.01).floor
      end
    end

  end
end
