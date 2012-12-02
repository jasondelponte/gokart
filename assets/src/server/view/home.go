package view

import (
	"github.com/jasondelponte/golib/text/html/template"
	"server/config"
)

type HomeView struct {
	template *template.Template
	config   *config.Config
}

func NewHomeView(tmpl *template.Template, cfg *config.Config) *HomeView {
	return &HomeView{
		template: tmpl,
		config:   cfg,
	}
}

func (v *HomeView) RenderWelcome() ([]byte, error) {
	common := template.CommonProps{
		Title:   "GoKart",
		Debug:   v.config.Debug,
		RootURL: v.config.URLRoot,
	}

	return v.template.Render("home", common, nil)
}
