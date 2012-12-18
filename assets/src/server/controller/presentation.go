package controller

import (
	"github.com/jasondelponte/golib/net/conn/httpserver"
	"log"
	"net/http"
	"server/config"
	"server/view"
)

type PresentationController struct {
	view         *view.PresentationView
	config       *config.Config
	HandlerFuncs struct {
		Show httpserver.HandlerFunc
	}
}

func NewPresentationController(view *view.PresentationView, cfg *config.Config) *PresentationController {
	c := &PresentationController{
		view:   view,
		config: cfg,
	}

	c.HandlerFuncs.Show = c.buildShowHandler()

	return c
}

func (c PresentationController) buildShowHandler() httpserver.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		if c.config.Debug {
			log.Println("PresentationController: DEBUG, Request received. Path:", r.URL.Path)
		}
		b, err := c.view.RenderPresentation()
		if err != nil {
			// TODO error response
			return
		}
		w.Write(b)
	}
}
