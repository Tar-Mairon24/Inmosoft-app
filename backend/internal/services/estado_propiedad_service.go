package services

import (
	"backend/internal/models"
	"database/sql"
	"log"
)

type EstadoPropiedadService struct {
	DB *sql.DB
}

// Constructor for the EstadoPropiedadService
func NewEstadoPropiedadService(db *sql.DB) *EstadoPropiedadService {
	return &EstadoPropiedadService{
		DB: db,
	}
}

// GET /estadoPropiedad/:id_tipo_propiedad
// Funcion que recupera el estado de la propiedad dependiedo del id_tipo_propiedad que biene en el get/prpopiedad/:id
func (service *EstadoPropiedadService) GetEstadoPropiedad(id int) (*models.EstadoPropiedades, error) {
	var estado models.EstadoPropiedades
	query := "SELECT * FROM Estado_Propiedades WHERE id_propiedad = ?"
	err := service.DB.QueryRow(query, id).Scan(&estado.IDEstadoPropiedades, &estado.TipoTransaccion, &estado.Estado, &estado.FechaCambioEstado)
	if err != nil {
		if err == sql.ErrNoRows {
			log.Println("No rows found")
			return nil, nil
		}
		log.Println("Error fetching estado:", err)
		return nil, err
	}

	return &estado, nil
}