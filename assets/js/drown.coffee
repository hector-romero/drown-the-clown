#= require vendor/jquery
#= require vendor/underscore
#= require vendor/backbone
#= require views/base
#= require views/welcome
#= require views/game
#= require views/finish

class ApplicationView extends Backbone.View

  showView:(nextView) ->
    showNext = =>
      nextView.render()
      @currentView = nextView
    if @currentView
      @currentView.hide showNext
    else
      showNext()

  lightBackground: =>
    if(false)
      move(@$('#background')[0])
        .duration('1s')
        .set('opacity', 0)
        .end();
    else
      @$('#background').animate {
        opacity: 0
      },1000

  initialize: ->
    @welcome = new Welcome(el: $("#welcome")[0])
    @game = new Game(el: $("#game")[0])
    @finish = new Finish(el: $("#bye")[0])

    @listenToOnce @welcome, "finish", => @showView(@game)
    @listenToOnce @game, "finish",(prize) =>
      @finish.setPrize(prize)
      @showView(@finish)
    @listenToOnce @finish, "finish", => location.reload()

  render: ->
    @lightBackground()
    @showView @welcome

class  Application

  init: ->
    @view = new ApplicationView(el: $("body")[0])
    @view.render()

window.app = new Application();