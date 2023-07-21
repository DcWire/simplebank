package db

import (
	"database/sql"
	"log"
	"os"
	"testing"

	"github.com/DcWire/simplebank/util"
	_ "github.com/lib/pq"
)

var testQueries *Queries
var testDB *sql.DB

func TestMain(m *testing.M) {
	var err error
	config, err := util.LoadConfig("../../.")
	if err != nil {
		log.Fatal("Unable to load config files: ", err)
	}
	testDB, err = sql.Open(config.DBDriver, config.DBSource)
	if err != nil {
		log.Fatal("Unable to connect to database")
	}

	testQueries = New(testDB)

	os.Exit(m.Run())

}
