window.PageFetcher = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
      new PageFetcher.Routers.Articles
      Backbone.history.start({pushState:true})
  }
};

$(document).ready(function(){
    PageFetcher.initialize();
});
