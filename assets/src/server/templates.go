package main

import (
	"bytes"
	"html/template"
	"log"
)

type Templates struct {
	tmpls *template.Template
}

// Object defining what all template data will use
type TmplProps struct {
	Common   *CommonProps
	Contents interface{}
}

// Generic properties shared by all templates
type CommonProps struct {
	Title   string
	Debug   bool
	RootURL string
	Host    string
}

// Loads the templates from disk and returns them loaded
// into memory.
func (t *Templates) LoadTemplates(path string) {
	t.tmpls = template.Must(template.ParseGlob(path + "/*.gotmpl"))
}

// Renders a template and returns the byte array for it
func (t *Templates) Render(tmplName string, common *CommonProps, contents interface{}) ([]byte, error) {
	buf := bytes.NewBuffer(nil)
	err := t.tmpls.ExecuteTemplate(buf, tmplName, &TmplProps{Common: common, Contents: contents})
	if err != nil {
		log.Println("Error: failed to execute template", tmplName, ", because", err)
	}

	return buf.Bytes(), err
}
