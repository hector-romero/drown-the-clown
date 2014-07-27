#= require views/base

class Finish extends BaseView
  events:
    'click ' : 'finish'

  setPrize: (prize) ->
    @prize = prize

  render: ->
    super
    if @prize && @prize.description
      alert @prize.description

# exports

window.Finish = Finish