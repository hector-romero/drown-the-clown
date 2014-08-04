#= require views/base

class Finish extends BaseView
  events:
    'click ' : 'finish'

  setPrize: (prize) ->
    @prize = prize

  render: ->
    if @prize && @prize.description
      @$el.addClass("you-win")
    super
# exports

window.Finish = Finish