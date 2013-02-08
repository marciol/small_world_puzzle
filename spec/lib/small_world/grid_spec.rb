require 'spec_helper'

describe SmallWorld::Grid do

  describe '.generate' do
    subject { grid }
    let (:grid) { SmallWorld::Grid.generate }

    context 'When calling with a rows hash parameter' do
      let (:grid) { SmallWorld::Grid.generate(columns: 50, rows: 50) }
      its (:columns) { should == 50 } 
      its (:rows) { should == 50 }
    end

    context 'When calling without parameters' do
      let (:grid) { SmallWorld::Grid.generate }
      its (:columns) { should == 100 }
      its (:rows) { should == 100 }
    end

    it 'should return an ramdom number of points to visit' do
      expected = 6.times.map { [1, 1] }
      SmallWorld::Grid.any_instance.stub(:generate) { expected.map { |(x, y)| SmallWorld::Point.new(x, y) } }
      result = subject.to_visit.map { |point| [point.x, point.y] }
      expect(result).to match_array expected
    end
  end

  describe '.load' do
    subject { grid }

    context 'When calling with a hash with :to_visit, :visited and :visitor keys' do
      let (:to_visit) { [ [1.0, 2.0], [5.0, 7.0], [3.0, 4.0], [1.0, 9.0] ] }
      let (:visited) { [ [9.0, 11.0], [2.0, 6.0], [4.0, 1.0] ] }
      let (:visitor) { [2.0, 11.0] }
      let (:grid) { SmallWorld::Grid.load to_visit: to_visit, visited: visited, visitor: visitor }

      it 'returns to visit' do
        result = subject.to_visit.map { |point| [point.x, point.y] }
        expect(result).to match_array to_visit
      end

      it 'returns visited' do
        result = subject.visited.map { |point| [point.x, point.y] }
        expect(result).to match_array visited 
      end

      it 'returns visitor' do
        result = subject.visitor.to_a
        expect(result).to match_array visitor
      end

    end
  end

  describe '#move_visitor!' do
    let (:grid) { SmallWorld::Grid.new }

    it 'call to_visit.closest_point_of(visitor)' do
      grid.to_visit.should_receive(:closest_point_of).with(grid.visitor)
      grid.move_visitor!
    end

    it 'call the visitor.move_in_direction_to' do
      grid.to_visit.stub(:closest_point_of) { double.as_null_object }
      grid.visitor.should_receive(:move_in_direction_to)
      grid.move_visitor!
    end
  end

  describe '#closest_points_of_visitor' do
    let (:grid) { SmallWorld::Grid.new }

    it 'call the to_visit.closest_points_of(visitor)' do
      grid.to_visit.should_receive(:closest_points_of).with(grid.visitor)
      grid.closest_points_of_visitor
    end
  end

  describe '#remains_any_point_to_visit?' do
    let (:grid) { SmallWorld::Grid.new }

    it 'call to_visit.any?' do
      grid.to_visit.should_receive(:any?)
      grid.remains_any_point_to_visit?
    end
  end

  describe '#to_json' do
    let (:grid_map) { { to_visit: [[1, 2], [3, 4]], visited: [[5, 6]], visitor: [7, 8] } }
    subject { SmallWorld::Grid.load grid_map }

    it 'return the json from grid status' do
      expect(subject.to_json).to eq(grid_map.to_json)
    end
  end

  describe '#to_hash' do
    let (:grid_map) { { to_visit: [[1, 2], [3, 4]], visited: [[5, 6]], visitor: [7, 8] } }
    subject { SmallWorld::Grid.load grid_map }

    it 'return the json from grid status' do
      expect(subject.to_hash).to eq(grid_map)
    end

  end
end
