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
                'Intro',
                'WhatIsGokart',
                'WhyCreate',
                'DevEnv',
                'WebServer',
                'HTML',
                'HTMLGo',
                'Client',
                'ClientTesting',
                'Improvements',
                'Questions'
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
