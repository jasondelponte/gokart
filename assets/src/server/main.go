package main

import (
	"flag"
	"log"
)

var addr = flag.String("addr", "", "IP address the server is to run on")
var port = flag.Uint("port", 0, "Port address to run the server on")
var rootURLPath = flag.String("root", "", "URL Path root of the webapp")
var tmplPath = flag.String("tmpl", "assets/templates", "Specifies the directory to use for template assets.")
var wwwPath = flag.String("www", "assets/www-debug", "Specifies the directory to use for web assest.")
var debug = flag.Bool("debug", false, "Enable debug mode where extra loging is produce, each request will reload templates, and all assets are served from non-concaticated files.")
var static = flag.Bool("static", false, "Enables serving up static content from disk")

func main() {
	flag.Parse()

	httpHndlr := &HttpHandler{
		Addr:        *addr,
		Port:        *port,
		RootURLPath: *rootURLPath,
		TmplPath:    *tmplPath,
		WwwPath:     *wwwPath,
		Debug:       *debug,
		ServStatic:  *static,
	}

	httpHndlr.HandleHttpConnection()
	log.Println("")
}
