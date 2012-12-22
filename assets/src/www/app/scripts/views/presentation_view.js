/*global define:true*/
define('views/presentation_view', [
    'jquery',
    'underscore',
    'backbone',
    'mustache',
    'highlight',
    'views/presentation_slide_view'
], function PresentationViewModule($, _, Backbone, Mustache, Highlight, PresentationSlideView) {
    'use strict';

    return Backbone.View.extend({
        className: '',
        template: $('#presentationContainerTemplate').html(),

        events: {
            'click .pres-slides': '_onNext',
            'click .pres-controls .prev': '_onPrev',
            'click .pres-controls .next': '_onNext'
        },
        _currentSlideIdx: 0,
        _slides: null,
        _slideViews: [],

        initialize: function initializeFunc(options) {
            this._slides = options.slides;

            this._onKeyPress = _.bind(this._onKeyPress, this);
        },

        render: function renderFunc() {
            this.$el.html(Mustache.render(this.template));
            this._slideViews = this._initSlideViews(this._slides);

            window.addEventListener('keyup', this._onKeyPress);

            return this;
        },

        showFirstSlide: function showFirstSlideFunc() {
            this._showSlide(0);
        },

        _initSlideViews: function _initSlideViewsFunc(slides) {
            var slideViews = [];
            var $slideCont = this.$('.pres-slides');
            for (var i=0; i < slides.length; i++) {
                var slide = new PresentationSlideView({slideId: slides[i]});
                slide.render();

                $slideCont.append(slide.$el);
                slideViews.push(slide);
            }
            return slideViews;
        },

        _onKeyPress: function onKeyUpFunc(event) {
            // TODO handle left/right arrows, enter and space for slide transition
            console.log(event.keyCode, event.keyIdentifier);
            var keyCode = event.keyCode;
            if (keyCode === 39 || keyCode === 13 || keyCode === 32) {
                this._onNext();
            }
            else if (keyCode === 37) {
                this._onPrev();
            }

            return false;
        },

        _onPrev: function onPrevFunc(event) {
            if (this._currentSlideIdx === 0) {
                return;
            }

            this._showSlide(this._currentSlideIdx-1, 'prev');
        },

        _onNext: function onNextFunc(event) {
            if (this._currentSlideIdx === this._slideViews.length-1) {
                return;
            }

            this._showSlide(this._currentSlideIdx+1, 'next');
        },

        _showSlide: function _showSlideFunc(index, dir) {
            var slide = this._slideViews[index];

            var prevSlide = this._slideViews[this._currentSlideIdx];
            if (dir === 'next' || dir === 'prev') {
                prevSlide.hide();
            }

            slide.show();
            slide.$('pre code').each(function(i, e) {
                Highlight.highlightBlock(e);
            });

            this.trigger('slideChanged');

            this._currentSlideIdx = index;
        }
    });
});