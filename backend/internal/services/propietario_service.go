package services

import (
	"backend/internal/models"
	"database/sql"
	"log"
)

type PropietarioService struct {
	DB *sql.DB
}

// Constructor for the PropiedadService
func NewPropietarioService(db *sql.DB) *PropietarioService {
	return &PropietarioService{
		DB: db,
	}
}

// GET /propietario/:id_propietario
// Funcion que recupera el propietario de la propiedad dependiendo del id_propietario que biene en el get/prpopiedad/:id
func (service *PropietarioService) GetPropietario(id int) (*models.Propietario, error) {
	var propietario models.Propietario
	query := "SELECT * FROM Propietario WHERE id_propietario = ?"
	err := service.DB.QueryRow(query, id).Scan(&propietario.IDPropietario, &propietario.Nombre, &propietario.ApellidoP, &propietario.ApellidoM, &propietario.Telefono, &propietario.Correo)
	if err != nil {
		if err == sql.ErrNoRows {
			log.Println("No rows found")
			return nil, nil
		}
		log.Println("Error fetching propietario:", err)
		return nil, err
	}
	return &propietario, nil
}