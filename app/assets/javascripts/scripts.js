
jQuery(document).ready(function() {
    /*
     Background slideshow
     */
    $('.coming-soon').backstretch([
        "/images/backgrounds/1.jpg"
        , "/images/backgrounds/2.jpg"
        , "/images/backgrounds/3.jpg"
    ], {duration: 3000, fade: 750});

    $(".item_house").hover(
        function () {
            $(this).find('.total_count').find('span').show();
        },
        function () {
            $(this).find('.total_count').find('span').hide();
        }
    );

});

