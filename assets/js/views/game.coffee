#= require views/base
#= require vendor/ballon

class Game extends BaseView
  moveBalloons: ->
    duration = "0.3s"
    move("#balloons").duration(duration).ease("out").translate(20, 40).then().duration(duration).ease("out").translate(-20, 40).then().duration(duration).ease("out").translate(20, 20).then().duration(duration).ease("out").translate(-20, 14).pop().pop().pop().end()

  moveClowns: (end) ->
    move("#clowns").add("bottom", 250).then().sub("bottom", 10).then().add("bottom", 10).then(end).pop().pop().end()

  showNumbers: ->
    duration = 300
    $("#number1").fadeIn duration, ->
      $("#number2").fadeIn duration, ->
        $("#number3").fadeIn duration, ->
          $("#number4").fadeIn duration, ->
            $("#number5").fadeIn duration


  render: ->
    @balloons = []
    @$el.fadeIn()
    window.setTimeout (=>
      @balloons.push new Ballon(1,
        property: "width"
        value: 110
      , this)
      @balloons.push new Ballon(2,
        property: "width"
        value: 68
      , this)
      @balloons.push new Ballon(3,
        property: "height"
        value: 58
      , this)
      @balloons.push new Ballon(4,
        property: "width"
        value: 55
      , this)
      @balloons.push new Ballon(5,
        property: "width"
        value: 110
      , this)
      @moveBalloons()
      @moveClowns @showNumbers
    ), 100

  drown: (number) ->
    i = 0
    hasToBoom =(number) =>
      => number == 3
    for balloon,i in @balloons
      balloon.drown hasToBoom i
    game = this

    window.setTimeout (=>
      @finish()

    ), 6000

#= exports
window.Game = Game