/*global define:true*/
define('views/presentation_slide_view',[
    'jquery',
    'underscore',
    'backbone',
    'mustache'
], function PresentationSlideViewModule($, _, Backbone, Mustache) {
    'use strict';

    return Backbone.View.extend({
        className: 'presentation-slide hidden',
        template: null,

        initialize: function initializeFunc(options) {
            this.template = $('#'+options.slideId+'Template').html();
        },

        hide: function hideFunc() {
            this.$el.addClass('hidden');
        },

        show: function showFunc() {
            this.$el.removeClass('hidden next prev');
        },

        render: function renderFunc() {
            this.$el.html(Mustache.render(this.template));
            return this;
        }
    });
});