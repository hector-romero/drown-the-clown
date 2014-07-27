#= require vendor/jquery
#= require vendor/underscore
#= require vendor/backbone
#= require views/base
#= require views/welcome
#= require views/game
#= require views/finish

class ApplicationView extends Backbone.View
  events:
    'click #welcome-you .button' : 'showGame'

  showView:(nextView) ->
    console.log "SHOW ViEW", nextView
    showNext = =>
      nextView.render()
      @currentView = nextView
    if @currentView
      @currentView.hide showNext
    else
      showNext()

  showGame: ->
    @showView @game

  lightBackground: =>
    move(@$('#background')[0])
      .duration('1s')
      .set('opacity', 0)
      .end();

  initialize: ->
    @welcome = new Welcome(el: $("#welcome")[0])
    @game = new Game(el: $("#game")[0])
    @finish = new Finish(el: $("#bye")[0])

    @listenToOnce @game, "game:finish", => @showView(@finish)

  render: ->
    @lightBackground()
    @showView @welcome

class  Application

  init: ->
    @view = new ApplicationView(el: $("body")[0])
    @view.render()

window.app = new Application();