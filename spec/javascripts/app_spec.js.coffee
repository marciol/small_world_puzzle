expect = chai.expect

describe 'SmallWorld.App', ->
    
    describe '.init', ->

        it 'builds new Grid object', ->
            grid = new window.SmallWorld.Grid()
            spy = sinon.stub(window.SmallWorld, 'Grid').returns(grid)
            window.SmallWorld.App.init()
            expect(spy).to.be.called
            window.SmallWorld.Grid.restore()

        it 'calls start() on the grid property', ->
            spy = sinon.stub(window.SmallWorld.Grid::, 'start')
            window.SmallWorld.App.init()
            window.SmallWorld.Grid::start.restore()
            expect(spy).to.be.called
