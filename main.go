package main

import (
	"encoding/json"
	"io"
	"log"
	"math/rand"
	"net/http"
	"strconv"
	"time"

	"github.com/labstack/echo/v4"
)

func generateRandomInt() int {
	s1 := rand.NewSource(time.Now().UnixNano())
	r1 := rand.New(s1)
	return r1.Intn(100)
}

func mapping(data []any, f func(any) string) []string {

	mapped := make([]string, len(data))

	for i, e := range data {
		mapped[i] = f(e)
	}

	return mapped
}

func selectRandomPokemon() string {
	var body map[string]any

	resp, err := http.Get("https://pokeapi.co/api/v2/pokemon/?limit=100&offset=0")
	if err != nil {
		log.Fatalln(err)
	}

	responseString, err := io.ReadAll(resp.Body)
	if err != nil {
		log.Fatalln(err)
	}

	err = json.Unmarshal(responseString, &body)
	if err != nil {
		log.Fatalln(err)
	}

	resuts := body["results"].([]any)

	names := mapping(resuts, func(i any) string {
		return i.(map[string]any)["name"].(string)
	})

	return names[generateRandomInt()]
}

func main() {
	e := echo.New()

	e.GET("/random_int", func(c echo.Context) error {
		return c.String(http.StatusOK, strconv.FormatInt(int64(generateRandomInt()), 10))
	})

	e.GET("/random_pokemon_name", func(c echo.Context) error {
		return c.String(http.StatusOK, selectRandomPokemon())
	})

	e.Logger.Fatal(e.Start(":3000"))
}
