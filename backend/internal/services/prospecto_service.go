package services

import (
	"backend/internal/database"
	"backend/internal/models"
	"database/sql"
	"log"
)

type ProspectoService struct {
	DB *sql.DB
}

// Constructor for the CitasService
func NewProspectoService(db *sql.DB) *ProspectoService {
	return &ProspectoService{
		DB: db,
	}
}

func (service *ProspectoService) InsertProspecto(prospecto *models.Prospecto) (int, error) {
	utils := database.NewDbUtilities(service.DB)
	lastId, err := utils.GetLastId("Prospecto", "id_cliente")
	if err != nil {
		log.Println("Error getting last Id:", err)
		return 0, err
	}
	prospecto.IdCliente = lastId + 1

	query := "INSERT INTO Prospecto(id_cliente, nombre_prospecto, apellido_paterno_prospecto, apellido_materno_prospecto, telefono_prospecto, correo_prospecto) VALUES(?,?,?,?,?,?)"
	result, err := service.DB.Exec(query, prospecto.IdCliente, prospecto.Nombre, prospecto.ApellidoP, prospecto.ApellidoM, prospecto.Telefono, prospecto.Correo)
	if err != nil {
		log.Println("Error inserting prospecto:", err)
		return 0, err
	}
	rows, err := result.RowsAffected()
	if err != nil {
		log.Println("Error getting rows affected:", err)
		return 0, err
	}
	if rows != 1 {
		log.Println("Error inserting prospecto, no rows affected")
		return 0, err
	}
	return prospecto.IdCliente, nil
}
