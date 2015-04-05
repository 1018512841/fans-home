fans_home.life_post = function () {
    return{
        life_picture_item_screen: function () {

            var $life_carousel = $("#myCarousel");

            function get_life_item_data(current_total, first_active) {
                $("#loading").show();
                var options = {
                    url: "/life_posts/display_life_item_picture",
                    type: "POST",
                    data: {start: current_total, first_active: first_active},
                    success: function (data) {
                        $life_carousel.find(".carousel-inner").append(data);
                        $(".bs-docs-life .total-number").text($("#total_life_item_number").val());
                        $life_carousel.carousel({
                            interval: false
                        }).on("slid", function () {
                            $(".bs-docs-life .current-number")
                                .text($life_carousel.find(".carousel-inner .active").index() + 1);
                        });
                        if (first_active != "active") {
                            $life_carousel.carousel("next");
                        }
                        $("#loading").hide();
                    }
                };
                $.ajax(options);
            }

            get_life_item_data(0, "active");

            $(".bs-docs-life .left.photo-control").click(function () {
                if ($(".carousel-inner .active").index() > 0) {
                    $life_carousel.carousel("prev");
                } else {
                    $(this).tooltip("show");
                }
                $(".bs-docs-life .right.photo-control").tooltip("destroy");
            });
            $(".bs-docs-life .right.photo-control").click(function () {
                var total = parseInt($(".bs-docs-life .total-number").text());
                var current_total = $(".carousel-inner .item").length;
                var current_number = $(".carousel-inner .active").index() + 1;
                if (current_number < current_total) {
                    $life_carousel.carousel("next");
                }

                if (current_number == current_total && current_total < total) {
                    get_life_item_data(current_total, "");

                }
                if (current_number == total) {
                    $(this).tooltip("show")
                }
                $(".bs-docs-life .left.photo-control").tooltip("destroy");
            });

        }
    }

}();
