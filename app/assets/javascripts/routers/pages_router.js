PageFetcher.Routers.Pages = Backbone.Router.extend({
    routes: {
        '':          'index'
    },

    initialize: function() {
        this.collection = new PageFetcher.Collections.Pages();
        this.collection.fetch();
    },

    index: function() {
        view = new PageFetcher.Views.PagesIndex({
            el:         $('body'),
            collection: this.collection
        });
    }
});
