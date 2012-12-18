package view

import (
	"github.com/jasondelponte/golib/text/html/template"
	"server/config"
)

type PresentationView struct {
	template *template.Template
	config   *config.Config
}

func NewPresentationView(tmpl *template.Template, cfg *config.Config) *PresentationView {
	return &PresentationView{
		template: tmpl,
		config:   cfg,
	}
}

func (v *PresentationView) RenderPresentation() ([]byte, error) {
	common := template.CommonProps{
		Title:   "GoKart Presentation",
		Debug:   v.config.Debug,
		RootURL: v.config.URLRoot,
	}

	if v.config.Debug {
		v.template.Reload()
	}

	return v.template.Render("presentation", common, nil)
}
