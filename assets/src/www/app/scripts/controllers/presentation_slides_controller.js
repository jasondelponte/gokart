/*global define:true*/
define('controllers/presentation_slides_controller', [
	'underscore',
	'backbone'
], function PresentationSlidesControllerModule(_, Backbone) {
    'use strict';

	function PresentationSlidesController(options) {
        this._container = options.container;
        this._slideViews = options.slideViews;
	}

	_.extend(PresentationSlidesController.prototype, Backbone.Events, {
        _currentSlideIdx: 0,

        firstSlide: function firstSlide() {
            this._showSlide(0);
        },

        nextSlide: function nextSlideFunc() {
            if (this._currentSlideIdx === this._slideViews.length-1) {
                return;
            }

            this._showSlide(this._currentSlideIdx-1, 'next');
        },

        prevSlide: function prevSlideFunc() {
            if (this._currentSlideIdx === 0) {
                return;
            }

            this._showSlide(this._currentSlideIdx+1, 'prev');
        },

        _showSlide: function _showSlideFunc(index, dir) {
            var slide = this._slideViews[index];

            var prevSlide = this._slideViews[this._currentSlideIdx];
            if (dir === 'next') {
                prevSlide.hideForNext();
            }
            else if (dir === 'prev') {
                prevSlide.hideForPrev();
            }

            slide.show();

            this._currentSlideIdx = index;
        }
	});

	return PresentationSlidesController;
});