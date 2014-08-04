var Ballon = function(number, drownAnimation, game) {
    var id = 'balloon' + number;
    var $number = $('#number' + number);
    var $balloon = $('#' + id + ' img.balloon');
    var $boom = $('#' + id + ' img.boom');
    var $splash = $('#' + id + ' img.splash');
    var $container = $('#' + id);
    var $drown = $('#splash' + number);

//    var init = function() {
//        console.log("Init")
//        $balloon.css('width', '18px');
//        $number.click(function() {
//            game.drown(number);
//        });
//    }
    
    var boom = function(hasToBoom) {
        return function() {
            if (hasToBoom()) {
                $balloon.hide();

                $splash.fadeIn('fast');

                $boom.fadeIn('fast', function() {
                    move('#' + id + ' img.boom')
                        .scale(1.2)
                        .end(hide);
                });
            }
        }
    };

    var hide = function() {
        $splash.fadeOut('fast');
        $boom.fadeOut('slow');
    };

    var expand = function(hasToBoom) {
        return function() {
            var scaleTo = (hasToBoom) ? 4: 3;
            move('#' + id + ' img.balloon')
                .duration('3.4s')
                .scale(scaleTo)
                .end(boom(hasToBoom));
        }
    };


    this.drown = function(hasToBoom) {
        move('#drown' + number)
            .add(drownAnimation.property, drownAnimation.value)
            .duration('1s')
            .ease('in')
            .then()
                .skew(-10)
                .duration('0.4s')
                .ease('in')
                .then()
                    .skew(10)
                    .duration('0.4s')
                    .ease('in')
                    .then()
                        .skew(-10)
                        .duration('0.4s')
                        .ease('in')
                        .then()
                            .skew(10)
                            .duration('0.4s')
                            .ease('in')
                            .then()
                                .skew(-10)
                                .duration('0.4s')
                                .ease('in')
                                .then()
                                    .skew(10)
                                    .duration('0.4s')
                                    .ease('in')
                                    .then()
                                        .sub(drownAnimation.property, drownAnimation.value)
                                        .duration('0.5s')
                                        .ease('in')
                                    .pop()
                                .pop()
                            .pop()
                        .pop()
                    .pop()
                .pop()
            .pop()
            .end(expand(hasToBoom));
    };

//    init();
    return this;
}
