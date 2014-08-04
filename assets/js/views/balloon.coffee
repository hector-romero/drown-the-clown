class Balloon extends Backbone.View

  initialize: (options)=>
    window["view" + options.number] = @
    @drownAnimation = options.animation
    @$balloon = @$("img.balloon")
    @$boom = @$("img.boom")
    @$splash = @$("img.splash")
    @number = options.number

  boom: (hasToBoom) =>
    =>
      if hasToBoom()
        @$balloon.hide()
        @$splash.fadeIn "fast"
        @$boom.fadeIn "fast", =>
          move(@$boom[0]).scale(1.2).end @hide

  hide: =>
    @$splash.fadeOut "fast"
    @$boom.fadeOut "slow"

  expand: (hasToBoom) =>
    =>
      scaleTo = (if (hasToBoom()) then 4 else 3)
      move(@$balloon[0]).duration("3.4s").scale(scaleTo).end @boom(hasToBoom)

  hasToBoom: ->
    null

  drown: (hasToBoom) =>
    @hasToBoom = hasToBoom
    move("#drown" + @number).add(@drownAnimation.property, @drownAnimation.value).duration("1s").ease("in").then().skew(-10).duration("0.4s").ease("in").then().skew(10).duration("0.4s").ease("in").then().skew(-10).duration("0.4s").ease("in").then().skew(10).duration("0.4s").ease("in").then().skew(-10).duration("0.4s").ease("in").then().skew(10).duration("0.4s").ease("in").then().sub(@drownAnimation.property, @drownAnimation.value).duration("0.5s").ease("in").pop().pop().pop().pop().pop().pop().pop().end @expand(hasToBoom)

#Exports
window.Balloon = Balloon