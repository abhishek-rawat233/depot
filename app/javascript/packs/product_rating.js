class Ratings {
  constructor(selectors) {
    this.rating = $(selectors.ratingId);
    this.ajaxOptions = selectors.ajaxOptions;
  }

  updateRatings = (e) => {
    var rating_selector = e.currentTarget
    var rating_selector_id = rating_selector.id
    $.ajax({
      url: this.ajaxOptions.url,
      type: this.ajaxOptions.method,
      data: {"rating_selector_id" : rating_selector_id,
             "product_id" : rating_selector.dataset.productId,
             "product_rating" : rating_selector.value
           },
      dataType: this.ajaxOptions.dataType,
      success: function(data) {
        $(rating_selector.dataset.averageRating).html(data["average_rating"])
      },
      failure: function(data) {
        $(rating_selector.dataset.averageRating).html('not working please refresh')
      }
    });
  }

  addEventToRatings = () => {
    $(this.rating).on('change', this.updateRatings);
  }

  init = () => {
    this.addEventToRatings();
  }
}


let selectors = {
  ratingId: '.product_rating',
  ajaxOptions: {
                  url: "/update_product_ratings",
                  method: "GET",
                  dataType: "json"
                 }
}

$(document).ready(function(){
  let rating = new Ratings(selectors);
  rating.init();
});
