#= require views/base

class Welcome extends BaseView
  events:
    'click .button' : 'finish'

  showPrize: =>
    @$('#prize').fadeIn 'fast', =>
       move(@$('#prize')[0])
         .scale(1)
         .end(@showSplash)

  showSplash: =>
    @$('#splash').fadeIn =>
         @showRibbon()

  showRibbon: =>
    @$('#ribbon-back').fadeIn =>
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

  showWelcome: =>
    window.setTimeout (=>
         @$('#welcome-you').fadeIn()
    ), 1000

  moveBalloons: ->
    return new Promise(=>
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

    )

  render: ->
    @moveBalloons()

#exports
window.Welcome = Welcome