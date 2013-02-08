require 'spec_helper'

describe SmallWorld::PointCollection do
  subject { SmallWorld::PointCollection.new(points) }

  describe '#closest_point_of' do
    let (:point) { SmallWorld::Point.new(2, 2) }

    context 'No points at all' do
      let (:points) { [] }

      it "returns nil" do
        result = subject.closest_point_of(point)
        expect(result).to eq(nil)
      end
    end

    context 'With 3 points' do
      let (:points) do
        [ SmallWorld::Point.new(4, 3), SmallWorld::Point.new(5, 7), SmallWorld::Point.new(3,3) ]
      end

      it 'returns Point(3, 3)' do 
        result = subject.closest_point_of(point)
        expect(result.x).to eq 3
        expect(result.y).to eq 3
      end
    end

    context 'With 3 points of which 2 have the same coordinates' do
      let (:first) { SmallWorld::Point.new(4, 4) }
      let (:second) { SmallWorld::Point.new(4, 4) }

      let (:points) do
        [ first, second, SmallWorld::Point.new(5, 7) ]
      end

      it 'returns the first_point' do
        result = subject.closest_point_of(point)
        expect(result).to eq first
      end 
    end

  end
end
