require 'spec_helper'

describe SmallWorld::Point do
  subject { subject_point }

  describe '#distance_of' do
    let (:subject_point) { SmallWorld::Point.new(2.0, 2.0) }

    context 'When x = 0.0 and y = 0.0' do
      let (:point) { SmallWorld::Point.new(0.0, 0.0) }

      it 'returns 2,83' do
        result = subject.distance_of(point)
        expect(result).to eq(2.83)
      end
    end

    context 'When x = 0.0 and y = 5.0' do
      let (:point) { SmallWorld::Point.new(0.0, 5.0) }

      it 'returns 3.61' do
        result = subject.distance_of(point)
        expect(result).to eq(3.61)
      end
    end

    context 'When x = 5.0 and y = 0.0' do
      let (:point) { SmallWorld::Point.new(5.0, 0.0) }
      
      it 'returns 3.61' do
        result = subject.distance_of(point)
        expect(result).to eq(3.61)
      end
    end

    context 'When x = 3.0 and y = 9.0' do
      let (:point) { SmallWorld::Point.new(3.0, 9.0) }

      it 'returns 7.07' do
        result = subject.distance_of(point)
        expect(result).to eq(7.07)
      end
    end
  end

  describe '#move_in_direction_to' do

    context 'When x = 5.0 and y = 4.0' do
      let (:subject_point) { SmallWorld::Point.new(5.0, 4.0) }
      let (:point) { SmallWorld::Point.new(2.0, 2.0) }
      let (:result) { subject.move_in_direction_to(point) }

      it 'returns x = 4.0' do
        expect(result.x).to eq 4.0 
      end

      it 'returns y = 3.33' do
        expect(result.y).to eq 3.33
      end
    end

    context 'When x = 2.0 and y = 2.0' do
      let (:subject_point) { SmallWorld::Point.new(2.0, 2.0) }
      let (:point) { SmallWorld::Point.new(5.0, 4.0) }
      let (:result) { subject.move_in_direction_to(point) }

      it 'returns x = 3.0' do
        expect(result.x).to eq 3.0
      end

      it 'returns y = 2.67' do
        expect(result.y).to eq 2.67
      end
    end
  end

end
