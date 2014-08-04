#= require views/base
#= require views/balloon
#= require service

getRandomWinner = (excluding)->
  list = [1..5]
  list.splice(excluding - 1,1)
  rand = list[Math.floor(Math.random() * list.length)]

class Game extends BaseView

  events:
    'click .number' : 'clickButton'

  clickButton: (e)->
    return if @playing
    @playing = true
    tId = ''
    if(e.currentTarget)
      tId = e.currentTarget.id
    else
      tId = e.target.id
    if(/[0-9].*/.exec(tId))
      @drown +(/[0-9].*/.exec(tId)[0])

  moveBalloons: ->
    if(false)
      duration = "0.3s"
      move("#balloons").duration(duration).ease("out").translate(20, 40).then().duration(duration).ease("out").translate(-20, 40).then().duration(duration).ease("out").translate(20, 20).then().duration(duration).ease("out").translate(-20, 14).pop().pop().pop().end()
    else
      $balloons = $("#balloonsWrapper")
      $balloons.animate {transform: 'translate(20,40)'},300, =>
        $balloons.animate {transform: 'translate(-20,70)'},300, =>
          $balloons.animate {transform: 'translate(20,100)'},300, =>
            $balloons.animate {transform: 'translate(-20,114)'},300

  moveClowns: (end) ->
    if(false)
      move("#clowns").add("bottom", 250).then().sub("bottom", 10).then().add("bottom", 10).then(end).pop().pop().end()
    else
      $clowns = $("#clowns")
      $clowns.animate {bottom: "+=250px"},500,=>
        $clowns.animate {bottom: "-=10px"},400,=>
          $clowns.animate {bottom: "+=10px"},400,=>
            end()

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
      @balloons.push new Balloon(
        number: 1
        el: @$("#balloon1")[0]
        animation:
          property: "width"
          value: 110
      )
      @balloons.push new Balloon(
        number: 2
        el: @$("#balloon2")[0]
        animation:
          property: "width"
          value: 55
      )
      @balloons.push new Balloon(
        number: 3
        el: @$("#balloon3")[0]
        animation:
          property: "height"
          value: 58
      )
      @balloons.push new Balloon(
        number: 4
        el: @$("#balloon4")[0]
        animation:
          property: "width"
          value: 55
      )
      @balloons.push new Balloon(
        number: 5
        el: @$("#balloon5")[0]
        animation:
          property: "width"
          value: 110
      )
      @moveBalloons()
      @moveClowns @showNumbers
    ), 100


  drown: (number) ->
    console.log number
    prize = null
    winner = getRandomWinner(number)
    timedOut = false
    service.getPrize(number ,(p)=>
      console.log "Got response", timedOut,p
      return if timedOut
      prize = p
      winner = number
    ,(e)->
        console.error(e)
    )
    i = 0
    hasToBoom =(index) =>
      balloon = index + 1
      =>
        timedOut = timedOut || index == number || index == winner
        balloon == winner
    for balloon,i in @balloons
      balloon.drown hasToBoom i
    game = this

    window.setTimeout (=>
      @finish(prize)

    ), 6000

#= exports
window.Game = Game