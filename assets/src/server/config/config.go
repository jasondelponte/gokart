package config

import (
	"fmt"
	"github.com/jasondelponte/golib/config"
	"net"
	"path"
	"strings"
)

type Config struct {
	Http struct {
		Address string `json:"address"`
		Port    int    `json:"port"`
	} `json:"http"`

	Templates string `json:"templates"`
	Assets    string `json:"assets"`

	URLRoot      string `json:"urlRoot"`
	URLRelAssets string `json:"urlAssets"`

	Debug bool `json:"debug"`

	URLFullAssetsPath string
}

func LoadConfig(fileName string) (*Config, error) {
	loader := config.NewJsonLoader(fileName)
	c := new(Config)

	if err := loader.Load(c); err != nil {
		return nil, err
	}

	if len(c.URLRoot) == 0 || !strings.HasPrefix(c.URLRoot, "/") {
		c.URLRoot = "/"
	}

	c.URLFullAssetsPath = c.buildURLFullAssetsPath()

	return c, nil
}

func (c Config) GetAddressWithPort() string {
	return net.JoinHostPort(c.Http.Address, fmt.Sprintf("%d", c.Http.Port))
}

func (c Config) buildURLFullAssetsPath() string {
	return path.Join(c.URLRoot, c.URLRelAssets) + "/"
}
