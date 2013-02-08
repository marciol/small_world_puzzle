expect = chai.expect

describe 'SmallWorld.Grid', ->

    gridExpected = ->
        ($.makeArray($('td', row)) for row in $('#grid tbody>tr', fixture.el))

    describe 'new', ->
        
        beforeEach ->
            fixture.load('grid.html')

        it 'assigns an array of rows and columns to @grid', ->
            grid = new window.SmallWorld.Grid('#grid')
            expected = gridExpected()
            expect(grid.grid).to.be.deep.equal(expected)

    describe '#populate()', ->
        state = 
            to_visit: [[1, 2], [3, 4], [5, 6]]
            visitor: [9, 10]

        beforeEach ->
            @spy = sinon.stub($, 'ajax').yieldsTo('success', state)
                                           
        afterEach ->
            $.ajax.restore()

        it 'calls grid create action', ->
            grid = new window.SmallWorld.Grid()
            grid.populate()
            argument = @spy.getCall(0).args[0]
            expect(argument).to.have.property('type', 'post')
            expect(argument).to.have.property('url','/grid')

        it 'assigns @state with data from server', ->
            grid = new window.SmallWorld.Grid()
            grid.populate()
            expect(grid.server).to.be.equal(state)

        it 'calls #populate_grid()', ->
            grid = new window.SmallWorld.Grid()
            grid.populate_grid()
            spy = sinon.spy(window.SmallWorld.Grid, 'populate_grid')
            expect(spy).to.be.called

        describe 'When fixtures are loaded', ->

            beforeEach ->
                fixture.load('grid.html')

            it 'populates to_visit cells', ->
                grid = new window.SmallWorld.Grid()
                grid.populate_grid()
                toVisit = ($('td.to_visit', row) for row in $('#grid tbody>tr'))
                expect(toVisit[1][3]).to.not.be.null

    describe '#update()', ->
        state = 
            to_visit: [[1, 2], [3, 4]]
            visited: [[5, 6]] 
            visitor: [9, 10]

        beforeEach ->
            sinon.stub($, 'ajax').yieldsTo('success', state)
                                           
        afterEach ->
            $.ajax.restore()

        it 'calls ajax with put', ->
            grid = new window.SmallWorld.Grid()
            spy = sinon.spy($, 'ajax')
            grid.update()
            expect(spy).to.be.calledWith('/grid', 'PUT')

        it 'calls update_visitor', ->
            grid = new window.SmallWorld.Grid()
            spy = sinon.spy(grid, 'update_visitor')
            grid.update()
            expect(spy).to.be.called

        it 'calls update_visited', ->
            grid = new window.SmallWorld.Grid()
            spy = sinon.spy(grid, 'update_visited')
            expect(spy).to.be.callled

        it 'calls update again if any to visit', ->
            grid = new window.SmallWorld.Grid()
            spy = sinon.spy(grid, 'update')
            grid.update()
            expect(spy).to.be.calledTwice

        it "shouldn't class update if not any to visit", ->
            grid = new window.SmallWorld.Grid()
            sinon.stub(grid.to_visit).returns([])
            grid.update()
            expect(spy).to.be.calledOnce
