App.product = App.cable.subscriptions.create("ProductChannel", {
  connected: function() {
    // Called when the subscription is ready for use on the server
  },

  disconnected: function() {
    // Called when the subscription has been terminated by the server
  },

  received: function(data) {
    // Called when there's incoming data on the websocket for this channel
    $('.alert.alert-info').show().delay(3000).fadeOut('slow');
    $('.product-reviews').prepend(data.comment);
    $('.page_entries').html(data.page_entries_info);
    $("#average-rating").attr('data-score', data.average_rating);
    $("#highest-rating").attr('data-score', data.highest_rating_comment);
    refreshRating();
  },

  listen_to_comments: function(){
    return this.perform('listen', {
      product_id: $("[data-product-id]").data("product-id")
    });
  }
});

$(document).on('turbolinks:load', function() {
  App.product.listen_to_comments();
});
