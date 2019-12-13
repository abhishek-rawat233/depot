function update_ratings(e) {
  rating_selector = e.currentTarget
  rating_selector_id = rating_selector.id
  $.ajax({
    url: "/update_product_ratings",
    type: "GET",
    data: {"rating_selector_id" : rating_selector_id,
           "product_id" : rating_selector.dataset.productId,
           "product_rating" : rating_selector.value
         },
    dataType: "json",
    success: function(data) {
      $(rating_selector.dataset.averageRating).html(data["average_rating"])
    },
    failure: function(data) {
      $(rating_selector.dataset.averageRating).html('not working please refresh')
    }
  });
}

$(document).ready(function(){
  $('.product_rating').on('change', update_ratings)
});
