package main

import (
	"fmt"
	"log"
	"net/http"
	"os"
	"regexp"
	"strings"
)

// HTTP Error Enumerables
type HttpError struct {
	ErrorString string
	CodeNum     int
}

func (h HttpError) Error() string                { return h.ErrorString }
func (h HttpError) Code() int                    { return h.CodeNum }
func (h HttpError) Report(w http.ResponseWriter) { http.Error(w, h.ErrorString, h.CodeNum) }

var (
	ErrHttpResourceNotFound = &HttpError{ErrorString: "Not found", CodeNum: 404}
	ErrHttpMethodNotAllowed = &HttpError{ErrorString: "Method not allowed", CodeNum: 405}
	ErrHttpBadRequeset      = &HttpError{ErrorString: "Bad request", CodeNum: 400}
	ErrHttpInternalError    = &HttpError{ErrorString: "Internal failure", CodeNum: 500}
)

type HttpHandler struct {
	RootURLPath    string
	TmplPath       string
	WwwPath        string
	Addr           string
	Port           uint
	Debug          bool
	ServStatic     bool
	templates      *Templates
	rootURLPathLen int
	wwwURLPathLen  int
}

// Load all the temmplates into memeory
func (h *HttpHandler) loadTemplates() {
	h.templates = &Templates{}
	h.templates.LoadTemplates(h.TmplPath)
}

// Configures the http connection and starts the listender
func (h *HttpHandler) HandleHttpConnection() {
	h.rootURLPathLen = len(h.RootURLPath + "/")
	h.wwwURLPathLen = len(h.RootURLPath + "/assets/")

	h.loadTemplates()

	h.initServeHomeHndlr(h.RootURLPath + "/")
	if h.Debug || h.ServStatic {
		h.initServeStaticHndlr(h.RootURLPath + "/assets/")
	}

	// Build the address with port if it's provided
	address := h.Addr
	if h.Port != 0 {
		address = fmt.Sprintf("%s:%d", h.Addr, h.Port)
	}

	err := http.ListenAndServe(address, nil)
	if err != nil {
		log.Fatal("ListenAndServe: ", err)
	}
}

// Network event handler for HTTP trafic. Serves up the 
// home.html file which will allow connection to the websocket
func (h *HttpHandler) initServeHomeHndlr(path string) {
	regProps := &CommonProps{
		Title:   "Go + WWW + Rake test app",
		Debug:   h.Debug,
		RootURL: h.RootURLPath,
		Host:    "",
	}

	hostPortRep := regexp.MustCompile(":\\d+$")

	http.HandleFunc(path, func(w http.ResponseWriter, r *http.Request) {
		if r.URL.Path != h.RootURLPath+"/" {
			ErrHttpResourceNotFound.Report(w)
			return
		}
		if r.Method != "GET" {
			ErrHttpMethodNotAllowed.Report(w)
			return
		}
		w.Header().Set("Content-Type", "text/html; charset=utf-8")

		// Normalalize http host
		if len(regProps.Host) == 0 {
			regProps.Host = r.Host
			if (h.Debug || h.ServStatic) && h.Port != 0 {
				if strings.Contains(r.Host, ":") {
					regProps.Host = hostPortRep.ReplaceAllString(r.Host, fmt.Sprintf(":%d", h.Port))
				} else {
					regProps.Host = fmt.Sprintf("%s:%d", r.Host, h.Port)
				}
			}
		}

		if h.Debug { // Force reloading of the template for each request in debug mode
			h.loadTemplates()
		}

		b, err := h.templates.Render("home", regProps, nil)
		if err != nil {
			log.Println("Failed to render template, home")
			return
		}

		w.Write(b)
	})
}

// Simple handler for serving static files
func (h *HttpHandler) initServeStaticHndlr(path string) {
	http.HandleFunc(path, func(w http.ResponseWriter, r *http.Request) {
		asset := r.URL.Path[h.wwwURLPathLen:]
		fullAssetPath := h.WwwPath + "/" + asset

		file, err := os.Open(fullAssetPath)
		if err != nil {
			ErrHttpResourceNotFound.Report(w)
			return
		}
		stat, err := file.Stat()
		if err != nil {
			ErrHttpInternalError.Report(w)
			return
		}
		http.ServeContent(w, r, asset, stat.ModTime(), file)
	})
}
