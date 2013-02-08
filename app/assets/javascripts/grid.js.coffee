window.SmallWorld ?= {}

class window.SmallWorld.Grid

    constructor: (id = '#grid') ->
        @grid = ($.makeArray($('td', row)) for row in $("#{id} tbody>tr"))

    start: ->
        console.log('foo')

    populate: ->
        $.post '/grid', (data) ->
            console.log(data)

