package services

import (
	"backend/internal/models"
	"database/sql"
	"log"
)

type TipoPropiedadService struct {
	DB *sql.DB
}

// Constructor for the PropiedadService
func NewTipoPropiedadService(db *sql.DB) *TipoPropiedadService {
	return &TipoPropiedadService{
		DB: db,
	}
}

// GET /tipoPropiedad/:id_tipo_propiedad
// Funcion que recupera el tipo de propiedad dependiendo del id_tipo_propiedad que biene en el get/prpopiedad/:id
func (service *TipoPropiedadService) GetTipoPropiedad(id int) (*models.TipoPropiedad, error) {
	var tipo models.TipoPropiedad
	query := "SELECT * FROM Tipo_Propiedad WHERE id_tipo_propiedad = ?"
	err := service.DB.QueryRow(query, id).Scan(&tipo.IDTipoPropiedad, &tipo.Tipo_Propiedad)
	if err != nil {
		if err == sql.ErrNoRows {
			log.Println("No rows found")
			return nil, nil
		}
		log.Println("Error fetching tipo:", err)
		return nil, err
	}
	return &tipo, nil
}
