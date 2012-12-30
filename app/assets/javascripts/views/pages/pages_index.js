PageFetcher.Views.PagesIndex = Backbone.View.extend({
    template: JST['pages/index'],

    events: {
        'submit': 'create'
    },

    initialize: function() {
        /* Error display */
        var errorTag = $('.flash-messages .alert');
        this.error = errorTag.length ? errorTag : $(this.el).prepend('<div class="alert alert-error"></div>');
        errorTag.html('');

        /* Collection events */
        this.collection.on('add', this.render, this);
    },

    render: function() {
        this.error.html('');
        $('ul').html(this.template({ pages: this.collection.toJSON() }));
        return this.el;
    },

    errors: function(article, response) {
        e = $.parseJSON(response.responseText).error;
        this.error.html(e);
    },

    create: function(event) {
        event.preventDefault();
        var attr = { fb_uid : $('#page_fb_uid').val()};

        this.collection.create(attr, {
            wait:  true,
            error: this.errors
        });
    }
});
