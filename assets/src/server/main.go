package main

import (
	"flag"
	"github.com/jasondelponte/golib/net/conn/httpserver"
	"github.com/jasondelponte/golib/text/html/template"
	"log"
	"server/config"
	"server/controller"
	"server/view"
)

var cfgFile = flag.String("config", "", "Configuration JSON file")

func main() {
	flag.Parse()

	var (
		cfg    *config.Config
		server *httpserver.HTTPServer
		tmpl   *template.Template
		err    error
	)

	if cfg, err = config.LoadConfig(*cfgFile); err != nil {
		log.Fatalln("Failed to load config, ", *cfgFile, ", because", err)
		return
	}

	if err = initDatabase(cfg); err != nil {
		log.Fatalln("Failed to initialize database, because", err)
		return
	}

	if tmpl, err = loadTemplates(cfg); err != nil {
		log.Fatalln("Failed to load HTML templates, because", err)
		return
	}

	if server, err = initServer(cfg, tmpl); err != nil {
		log.Fatalln("Failed to initialize HTTP(s) server configuration, because", err)
		return
	}

	server.Run()
}

func initDatabase(cfg *config.Config) error {
	return nil
}

func loadTemplates(cfg *config.Config) (*template.Template, error) {
	tmpl := new(template.Template)

	if err := tmpl.Load(cfg.Templates); err != nil {
		return tmpl, err
	}

	return tmpl, nil
}

func initServer(cfg *config.Config, tmpl *template.Template) (*httpserver.HTTPServer, error) {

	server := httpserver.NewHTTPServer(cfg.GetAddressWithPort(), cfg.Debug)

	home := controller.NewHomeController(view.NewHomeView(tmpl, cfg), cfg)
	server.AddHandlerFunc(cfg.URLRoot, home.HandlerFuncs.Welcome)

	static := controller.NewStaticAssetController(cfg)
	server.AddHandlerFunc(cfg.URLFullAssetsPath, static.HandlerFuncs.StaticAssets)

	return server, nil
}
