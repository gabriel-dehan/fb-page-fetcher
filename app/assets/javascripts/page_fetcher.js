window.PageFetcher = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
      $('.no-js').removeClass('no-js');

      new PageFetcher.Routers.Pages
      Backbone.history.start({pushState:true})
  }
};

$(document).ready(function(){
    PageFetcher.initialize();
});
