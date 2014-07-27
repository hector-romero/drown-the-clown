#= require views/base

class Finish extends BaseView
  events:
    'click ' : 'finish'

  setPrize: (prize) ->
    @prize = prize

# exports

window.Finish = Finish
