module SmallWorld

  class Line

    def initialize(first_point, second_point)
      @matrix = [ first_point.to_a, second_point.to_a ]
    end

    def point_on_y_axis(y_coordinate)
      m = @matrix 

      dividend =
        m[0][0] * m[1][1] +
        m[1][0] * y_coordinate -
        m[0][0] * y_coordinate -
        m[1][0] * m[0][1]

      divisor = m[1][1] - m[0][1]

      x_coordinate = (dividend / divisor).round(2)

      Point.new(x_coordinate, y_coordinate)
    end

    def point_on_x_axis(x_coordinate)
      m = @matrix 

      dividend =
        m[0][0] * m[1][1] +
        m[0][1] * x_coordinate -
        m[1][1] * x_coordinate -
        m[1][0] * m[0][1]

      divisor = m[0][0] - m[1][0]

      y_coordinate = (dividend / divisor).round(2)

      Point.new(x_coordinate, y_coordinate)
    end

    def slope
      m = @matrix
      ((m[0][1] - m[1][1]) / (m[0][0] - m[1][0])).round(2)
    end
  end
end
