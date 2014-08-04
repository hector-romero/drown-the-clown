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
          if(false && Modernizr.cssanimations) #TODO Check if it's the correct check
            move(@$boom[0]).scale(1.2).end @hide
          else
            width = @$boom.width()
            animation = {
                width: (width * 1.2) + "px"
                left: "-" + Math.round(((width - 4)* 1.2) / 2) + "px"
            }
            @$balloon.animate animation, 200, @hide

  hide: =>
    @$splash.fadeOut "fast"
    @$boom.fadeOut "slow"

  expand: (hasToBoom) =>
    =>
      scaleTo = (if (hasToBoom()) then 4 else 3)
      if(false && Modernizr.cssanimations) #TODO Check if it's the correct check
        move(@$balloon[0]).duration("3.4s").scale(scaleTo).end @boom(hasToBoom)
      else
        width = @$balloon.width()
        animation = {
            width: (width * scaleTo) + "px"
            left: "-" + Math.round(((width - 4)* scaleTo) / 2) + "px"
        }
        @$balloon.animate animation, 3400, @boom hasToBoom

  drown: (hasToBoom) =>
    $drown = $("#drown" + @number)
    if(false &&  Modernizr.cssanimations) #TODO Check if it's the correct check
      move($drown[0]).add(@drownAnimation.property, @drownAnimation.value).duration("1s").ease("in").then().skew(-10).duration("0.4s").ease("in").then().skew(10).duration("0.4s").ease("in").then().skew(-10).duration("0.4s").ease("in").then().skew(10).duration("0.4s").ease("in").then().skew(-10).duration("0.4s").ease("in").then().skew(10).duration("0.4s").ease("in").then().sub(@drownAnimation.property, @drownAnimation.value).duration("0.5s").ease("in").pop().pop().pop().pop().pop().pop().pop().end @expand(hasToBoom)

    else
      animation = {add: {},sub:{},end:{}}
      animation.add[@drownAnimation.property] = @drownAnimation.value + "px";
      animation.sub[@drownAnimation.property] = @drownAnimation.value - 10 + "px";
      animation.end[@drownAnimation.property] = "0px";

      $drown.animate animation.add,1000,=>
        @expand(hasToBoom)()
        $drown.animate animation.sub,400, =>
          $drown.animate animation.add,400, =>
            $drown.animate animation.sub,400, =>
              $drown.animate animation.add,400, =>
                $drown.animate animation.sub,400, =>
                  $drown.animate animation.add,400, =>
                    $drown.animate animation.end,500



#Exports
window.Balloon = Balloon