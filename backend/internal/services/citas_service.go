package services

import (
	"backend/internal/database"
	"backend/internal/models"
	"database/sql"
	"log"
)

type CitasService struct {
	DB *sql.DB
}

// Constructor for the CitasService
func NewCitasService(db *sql.DB) *CitasService {
	return &CitasService{
		DB: db,
	}
}

// Funcion que recupera todas las citas de la base de datos
func (service *CitasService) GetAllCitasUser(IdUsuario int) ([]*models.CitaMenu, error) {
	var citas []*models.CitaMenu
	query := "SELECT id_citas, titulo_cita, fecha_cita, hora_cita, nombre_prospecto, apellido_paterno_prospecto, apellido_materno_prospecto FROM Citas, Prospecto where id_usuario = ? and Prospecto.id_cliente = Citas.id_cliente"
	rows, err := service.DB.Query(query, IdUsuario)
	if err != nil {
		if err == sql.ErrNoRows {
			log.Println("No rows found")
			return nil, nil
		}
		log.Println("Error fetching all citas:", err)
		return nil, err
	}
	defer rows.Close()

	for rows.Next() {
		var cita models.CitaMenu
		err := rows.Scan(&cita.IDCita, &cita.Titulo, &cita.FechaCita, &cita.HoraCita, &cita.NombreCliente, &cita.ApellidoPaternoCliente, &cita.ApellidoMaternoCliente)
		if err != nil {
			log.Println("Error scanning cita:", err)
			return nil, err
		}
		citas = append(citas, &cita)
	}

	if err = rows.Err(); err != nil {
		log.Println("Error with rows:", err)
		return nil, err
	}
	return citas, nil
}

func (service *CitasService) GetCita(id int) (*models.Cita, error) {
	var cita models.Cita
	query := "SELECT * FROM Citas WHERE id_citas = ?"
	row := service.DB.QueryRow(query, id)
	err := row.Scan(&cita.IDCita, &cita.Titulo, &cita.FechaCita, &cita.HoraCita, &cita.Descripcion, &cita.IdUsuario, &cita.IdCliente, &cita.IdPropiedad)
	if err != nil {
		if err == sql.ErrNoRows {
			log.Println("No rows found")
			return nil, nil
		}
		log.Println("Error fetching cita:", err)
		return nil, err
	}
	return &cita, nil
}

// Funcion que inserta una cita en la base de datos
func (service *CitasService) InsertCita(cita *models.Cita) error {
	utils := database.NewDbUtilities(service.DB)
	lastId, err := utils.GetLastId("Citas", "id_citas")
	if err != nil {
		log.Println("Error getting last Id:", err)
		return err
	}
	cita.IDCita = lastId + 1
	query := "INSERT INTO Citas (id_citas, titulo_cita, fecha_cita, hora_cita, descripcion_cita, id_usuario, id_cliente, id_propiedad) VALUES (?, ?, ?, ?, ?, ?, ?, ?)"
	result, err := service.DB.Exec(query, cita.IDCita, cita.Titulo, cita.FechaCita, cita.HoraCita, cita.Descripcion, cita.IdUsuario, cita.IdCliente, cita.IdPropiedad)
	if err != nil {
		log.Println("Error inserting cita:", err)
		return err
	}
	rows, err := result.RowsAffected()
	if err != nil {
		log.Println("Error getting rows affected:", err)
		return err
	}
	if rows != 1 {
		log.Println("Error inserting cita, no rows affected")
		return err
	}
	return nil
}

// Funcion que actualiza una cita en la base de datos
func (service *CitasService) UpdateCita(cita *models.Cita) error {
	print(cita.Titulo)
	utils := database.NewDbUtilities(service.DB)
	lastId, err := utils.GetLastId("Citas", "id_citas")
	if err != nil {
		log.Println("Error getting last ID:", err)
		return err
	}
	if cita.IDCita <= 0 || cita.IDCita > lastId {
		log.Println("Invalid propiedad ID:", cita.IDCita)
		return err
	}
	query := "UPDATE Citas SET titulo_cita = ?, fecha_cita = ?, hora_cita = ?, descripcion_cita = ?, id_usuario = ?, id_cliente = ?, id_propiedad = ? WHERE id_citas = ?"
	result, err := service.DB.Exec(query, cita.Titulo, cita.FechaCita, cita.HoraCita, cita.Descripcion, cita.IdUsuario, cita.IdCliente, cita.IdPropiedad, cita.IDCita)
	if err != nil {
		log.Println("Error updating cita:", err)
		return err
	}
	rows, err := result.RowsAffected()
	if err != nil {
		log.Println("Error getting rows affected:", err)
		return err
	}
	if rows == 0 {
		log.Println("Error updating cita, no rows affected")
		return err
	}
	return nil
}

// Funcion que elimina una cita de la base de datos
func (service *CitasService) DeleteCita(id int) error {
	utils := database.NewDbUtilities(service.DB)
	lastId, err := utils.GetLastId("Citas", "id_citas")
	if err != nil {
		log.Println("Error getting last ID:", err)
		return err
	}
	if id <= 0 || id > lastId {
		log.Println("Invalid propiedad ID:", id)
		return err
	}
	query := "DELETE FROM Citas WHERE id_citas = ?"
	result, err := service.DB.Exec(query, id)
	if err != nil {
		log.Println("Error deleting cita:", err)
		return err
	}
	rows, err := result.RowsAffected()
	if err != nil {
		log.Println("Error getting rows affected:", err)
		return err
	}
	if rows == 0 {
		log.Println("Error deleting cita, no rows affected")
		return err
	}
	return nil
}
