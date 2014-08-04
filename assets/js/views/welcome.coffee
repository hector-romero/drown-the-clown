#= require views/base

class Welcome extends BaseView
  events:
    'click .button' : 'finish'

  showPrize: =>
    @$('#prize').fadeIn 'fast', =>
      if(false)
         move(@$('#prize')[0])
           .scale(1)
           .end(@showSplash)
      else
        $prize = @$('#prize')
        $prize.fadeIn 400
        $prize.animate {
          transform: 'scale(1)'
        }, 500, @showSplash
#
  showSplash: =>
    @$('#splash').fadeIn =>
         @showRibbon()

  showRibbon: =>
    @$('#ribbon-back').fadeIn =>
      if(false)
         move(@$('#ribbon1')[0])
           .add('width', 209)
           .duration('0.5s')
           .ease('in')
           .end();
         move(@$('#ribbon2')[0])
           .add('width', 209)
           .duration('0.5s')
           .ease('in')
           .end(@showWelcome)
      else
        $r1 = @$('#ribbon1')
        $r2 = @$('#ribbon2')
        animate = ($r,callback)=>
          $r.animate {width: "+=209px"},500, =>
            $r.animate {width: "-=40px"},100, =>
              $r.animate {width: "+=40px"},150, callback
        animate($r1)
        animate($r2,@showWelcome)

  showWelcome: =>
    window.setTimeout (=>
         @$('#welcome-you').fadeIn()
    ), 800

  moveBalloons: ->
    if (false)
      move(@$('.flight-balloons')[0])
        .duration('1s')
        .ease('in-out')
        .translate(0, -420)
        .then()
        .duration('1s')
        .ease('in-out')
        .translate(0, 50)
        .then(@showPrize)
        .pop()
        .end();
    else
      $balloons = @$("#balloonsFlyingWrapper")
#      $balloons = @$(".flight-balloons")
      $balloons.animate {transform: 'translate(0, -420)'},1000, =>
        $balloons.animate {transform: 'translate(0,-370)'},500, =>
          @showPrize()
#          $balloons.animate {transform: 'translate(0,-230)'},1000, =>
#            $balloons.animate {transform: 'translate(0,-398)'},1000, =>


  render: ->
    @moveBalloons()

#exports
window.Welcome = Welcome