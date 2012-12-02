package controller

import (
	"github.com/jasondelponte/golib/net/conn/httpserver"
	"log"
	"net/http"
	"os"
	"path"
	"server/config"
)

type StaticAssetController struct {
	HandlerFuncs struct {
		StaticAssets httpserver.HandlerFunc
	}

	config          *config.Config
	urlAssetPathLen int
}

func NewStaticAssetController(cfg *config.Config) *StaticAssetController {
	c := &StaticAssetController{
		config:          cfg,
		urlAssetPathLen: len(cfg.URLFullAssetsPath),
	}

	c.HandlerFuncs.StaticAssets = c.buildStaticHandler()

	return c
}

func (c StaticAssetController) buildStaticHandler() httpserver.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		if c.config.Debug {
			log.Println("StaticAssetController: DEBUG, Request received. Path:", r.URL.Path)
		}

		asset := r.URL.Path[c.urlAssetPathLen:]
		fullAssetPath := path.Join(c.config.Assets, asset)

		c.serveStaticAsset(fullAssetPath, w, r)
	}
}

func (c StaticAssetController) serveStaticAsset(asset string, w http.ResponseWriter, r *http.Request) {
	file, err := os.Open(asset)
	if err != nil {
		httpserver.ErrHttpResourceNotFound.Report(w)
		return
	}
	stat, err := file.Stat()
	if err != nil {
		httpserver.ErrHttpInternalError.Report(w)
		return
	}
	http.ServeContent(w, r, asset, stat.ModTime(), file)
}
