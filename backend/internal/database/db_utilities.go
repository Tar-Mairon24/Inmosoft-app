package database

import (
	"database/sql"
	"fmt"
)

type Db_Utilities struct{
	db *sql.DB
}

func NewDbUtilities(db *sql.DB) *Db_Utilities {
	return &Db_Utilities{
		db: db,
	}
}

func (dbu *Db_Utilities) GetLastId(table string, idName string) (int, error) {
	var id int
	query := fmt.Sprintf("Select max(%s) from %s", idName, table)
	err := dbu.db.QueryRow(query).Scan(&id)
	if err != nil {
		return 0, err
	}
	return id, nil
}

