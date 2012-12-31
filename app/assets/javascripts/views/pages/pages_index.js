PageFetcher.Views.PagesIndex = Backbone.View.extend({
    template: JST['pages/index'],

    events: {
        'submit': 'create'
    },

    initialize: function() {
        /* Error display */
        var errorTag = $('.flash-messages .alert').hide();
        this.error = errorTag.length ? errorTag : $('.flash-messages').prepend('<div class="alert alert-error" style="display: none"></div>');
        errorTag.html('');

        /* Collection events */
        this.collection.on('add', this.refresh, this);
    },

    refresh: function() {
        var self = this;
        this.collection.fetch({
            success: function(collection) {
                self.collection = collection;
                self.render();
            }
        })
    },

    render: function() {
        $('.flash-messages .alert').html('');
        $('ul').html(this.template({ pages: this.collection.toJSON() }));
        return this.el;
    },

    errors: function(article, response) {
        e = $.parseJSON(response.responseText).error;
        $('.flash-messages .alert').fadeIn().html(e);
    },

    create: function(event) {
        event.preventDefault();
        var attr = { fb_uid : $('#page_fb_uid').val()};
        console.log('its here');
        this.collection.create(attr, {
            wait:  true,
            error: this.errors
        });
    }
});
