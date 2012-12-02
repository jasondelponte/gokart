package controller

import (
	"github.com/jasondelponte/golib/net/conn/httpserver"
	"log"
	"net/http"
	"server/config"
	"server/view"
)

type HomeController struct {
	view         *view.HomeView
	config       *config.Config
	HandlerFuncs struct {
		Welcome httpserver.HandlerFunc
	}
}

func NewHomeController(view *view.HomeView, cfg *config.Config) *HomeController {
	c := &HomeController{
		view:   view,
		config: cfg,
	}

	c.HandlerFuncs.Welcome = c.buildWelcomeHandler()

	return c
}

func (c HomeController) buildWelcomeHandler() httpserver.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		if c.config.Debug {
			log.Println("HomeController: DEBUG, Request received. Path:", r.URL.Path)
		}
		b, err := c.view.RenderWelcome()
		if err != nil {
			// TODO error response
			return
		}

		w.Write(b)
	}
}
