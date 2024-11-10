package services

import (
	"backend/internal/database"
	"backend/internal/models"
	"database/sql"
	"log"
)

// ProspectoService es el servicio para manejar operaciones relacionadas con Prospecto
type ProspectoService struct {
	DB *sql.DB
}

// NewProspectoService es el constructor para ProspectoService
func NewProspectoService(db *sql.DB) *ProspectoService {
	return &ProspectoService{
		DB: db,
	}
}

// GetAllProspectos recupera todos los prospectos de la base de datos
func (service *ProspectoService) GetAllProspectos() ([]*models.Prospecto, error) {
	var prospectos []*models.Prospecto
	query := "SELECT id_cliente, nombre_prospecto, apellido_paterno_prospecto, apellido_materno_prospecto, telefono_prospecto, correo_prospecto FROM Prospecto"
	rows, err := service.DB.Query(query)
	if err != nil {
		if err == sql.ErrNoRows {
			log.Println("No se encontraron prospectos")
			return nil, nil
		}
		log.Println("Error al obtener todos los prospectos:", err)
		return nil, err
	}
	defer rows.Close()

	for rows.Next() {
		var prospecto models.Prospecto
		err := rows.Scan(
			&prospecto.IDPropietario,
			&prospecto.Nombre,
			&prospecto.ApellidoP,
			&prospecto.ApellidoM,
			&prospecto.Telefono,
			&prospecto.Correo,
		)
		if err != nil {
			log.Println("Error al escanear prospecto:", err)
			return nil, err
		}
		prospectos = append(prospectos, &prospecto)
	}

	if err = rows.Err(); err != nil {
		log.Println("Error con las filas de prospectos:", err)
		return nil, err
	}

	return prospectos, nil
}

// GetProspecto recupera un prospecto específico por su ID
func (service *ProspectoService) GetProspecto(id int) (*models.Prospecto, error) {
	var prospecto models.Prospecto
	query := "SELECT id_cliente, nombre_prospecto, apellido_paterno_prospecto, apellido_materno_prospecto, telefono_prospecto, correo_prospecto FROM Prospecto WHERE id_cliente = ?"
	err := service.DB.QueryRow(query, id).Scan(
		&prospecto.IDPropietario,
		&prospecto.Nombre,
		&prospecto.ApellidoP,
		&prospecto.ApellidoM,
		&prospecto.Telefono,
		&prospecto.Correo,
	)
	if err != nil {
		if err == sql.ErrNoRows {
			log.Println("No se encontró el prospecto con ID:", id)
			return nil, nil
		}
		log.Println("Error al obtener el prospecto:", err)
		return nil, err
	}

	return &prospecto, nil
}

// CreateProspecto inserta un nuevo prospecto en la base de datos
func (service *ProspectoService) CreateProspecto(prospecto *models.Prospecto) (int, error) {
	utils := database.NewDbUtilities(service.DB)
	lastID, err := utils.GetLastId("Prospecto", "id_cliente")
	if err != nil {
		log.Println("Error al obtener el último ID:", err)
		return 0, err
	}
	prospecto.IDPropietario = lastID + 1

	query := "INSERT INTO Prospecto(id_cliente, nombre_prospecto, apellido_paterno_prospecto, apellido_materno_prospecto, telefono_prospecto, correo_prospecto) VALUES(?,?,?,?,?,?)"
	result, err := service.DB.Exec(query,
		prospecto.IDPropietario,
		prospecto.Nombre,
		prospecto.ApellidoP,
		prospecto.ApellidoM,
		prospecto.Telefono,
		prospecto.Correo,
	)
	if err != nil {
		log.Println("Error al insertar prospecto:", err)
		return 0, err
	}

	rows, err := result.RowsAffected()
	if err != nil {
		log.Println("Error al obtener filas afectadas:", err)
		return 0, err
	}
	if rows != 1 {
		log.Println("Error al insertar prospecto: no se afectaron filas")
		return 0, err
	}

	return prospecto.IDPropietario, nil
}

// UpdateProspecto actualiza un prospecto existente en la base de datos
func (service *ProspectoService) UpdateProspecto(prospecto *models.Prospecto, id int) error {
	utils := database.NewDbUtilities(service.DB)
	lastID, err := utils.GetLastId("Prospecto", "id_cliente")
	if err != nil {
		log.Println("Error al obtener el último ID:", err)
		return err
	}

	if id <= 0 || id > lastID {
		log.Println("ID de prospecto inválido:", id)
		return sql.ErrNoRows
	}

	query := "UPDATE Prospecto SET nombre_prospecto = ?, apellido_paterno_prospecto = ?, apellido_materno_prospecto = ?, telefono_prospecto = ?, correo_prospecto = ? WHERE id_cliente = ?"
	result, err := service.DB.Exec(query,
		prospecto.Nombre,
		prospecto.ApellidoP,
		prospecto.ApellidoM,
		prospecto.Telefono,
		prospecto.Correo,
		id,
	)
	if err != nil {
		log.Println("Error al actualizar prospecto:", err)
		return err
	}

	rows, err := result.RowsAffected()
	if err != nil {
		log.Println("Error al obtener filas afectadas:", err)
		return err
	}
	if rows != 1 {
		log.Println("Error al actualizar prospecto: no se afectaron filas")
		return sql.ErrNoRows
	}

	return nil
}

// DeleteProspecto elimina un prospecto de la base de datos
func (service *ProspectoService) DeleteProspecto(id int) error {
	utils := database.NewDbUtilities(service.DB)
	lastID, err := utils.GetLastId("Prospecto", "id_cliente")
	if err != nil {
		log.Println("Error al obtener el último ID:", err)
		return err
	}

	if id <= 0 || id > lastID {
		log.Println("ID de prospecto inválido:", id)
		return sql.ErrNoRows
	}

	query := "DELETE FROM Prospecto WHERE id_cliente = ?"
	result, err := service.DB.Exec(query, id)
	if err != nil {
		log.Println("Error al eliminar prospecto:", err)
		return err
	}

	rows, err := result.RowsAffected()
	if err != nil {
		log.Println("Error al obtener filas afectadas:", err)
		return err
	}
	if rows == 0 {
		log.Println("Error al eliminar prospecto: no se afectaron filas")
		return sql.ErrNoRows
	}

	return nil
}
