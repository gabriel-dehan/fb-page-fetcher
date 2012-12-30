PageFetcher.Collections.Pages = Backbone.Collection.extend({
    url: '/api/pages',
    model: PageFetcher.Models.Pages
});
