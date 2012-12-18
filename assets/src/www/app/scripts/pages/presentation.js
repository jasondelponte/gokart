/*global define:true*/
define('pages/presentation_page', [
    'jquery',
	'underscore',
    'views/presentation_view'
], function PresentationPageModule($, _, PresentationView) {
    'use strict';

	function PresentationPage(options) {
		this._container = $(options.container);

        this.view = new PresentationView({
            slides: [
                'slide1Intro',
                'slide2WhatIsGokart',
                'slide3DevEnv',
                'slide4WebServer',
                'slide5Client',
                'slide6Improvements',
            ]
        });
	}

	_.extend(PresentationPage.prototype, {
		start: function () {
            this.view.render();
            this._container.append(this.view.$el);

            this.view.showFirstSlide();
		}
	});

	return PresentationPage;
});
