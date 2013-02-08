require 'spec_helper'

describe SmallWorld::Line do
  subject { SmallWorld::Line.new(first_point, second_point) }
  let (:first_point) { SmallWorld::Point.new(2.0, 2.0) }
  let (:second_point) { SmallWorld::Point.new(5.0, 4.0) }


  describe '#point_on_x_axis' do
    context 'When x = 3.0' do
      it 'returns 2.67' do
        result = subject.point_on_x_axis(3.0)
        expect(result.y).to eq 2.67
      end
    end

    context 'When x = 4.0' do
      it 'returns 3.33' do
        result = subject.point_on_x_axis(4.0)
        expect(result.y).to eq 3.33
      end
    end

  end
  
  describe '#point_on_y_axis' do
    context 'When y = 3.0' do
      it 'returns 3.5' do
        result = subject.point_on_y_axis(3.0)
        expect(result.x).to eq 3.5
      end 
    end

    context 'When y = 4' do
      it 'returns 5.0' do
        result = subject.point_on_y_axis(4.0)
        expect(result.x).to eq 5.0
      end
    end
  end

  describe '#slope' do
    it 'returns 0.67' do
      expect(subject.slope).to eq 0.67
    end
  end
end
