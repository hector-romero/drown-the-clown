#= require vendor/jquery
#= require vendor/underscore
#= require vendor/backbone
#= require vendor/move

class BaseView extends  Backbone.View

  render: ->
    @$el.fadeIn()

  hide:(finish) ->
    @$el.fadeOut finish

#exports

window.BaseView = BaseView