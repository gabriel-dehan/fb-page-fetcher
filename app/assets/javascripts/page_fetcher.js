window.PageFetcher = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
      new PageFetcher.Routers.Pages
      Backbone.history.start({pushState:true})
  }
};

$(document).ready(function(){
    PageFetcher.initialize();
});
