module SmallWorld

  class PointCollection < Array

    def closest_point_of(point)
      self.min_by { |item| item.distance_of(point) }
    end  

    def closest_points_of(point)
      self.sort { |a, b| b.distance_of(point) <=> a.distance_of(point) }
    end

  end
end
