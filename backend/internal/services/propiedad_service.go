package services

import (
	"backend/internal/models"
	"database/sql"
	"log"
)

type PropiedadService struct {
	DB *sql.DB
}

// Constructor for the PropiedadService
func NewPropiedadService(db *sql.DB) *PropiedadService {
	return &PropiedadService{
		DB: db,
	}
}

// Funcion que recupera todas las propiedades de la base de datos, solo recupera los campos necesarios para mostrar en el menú, el resto de los campos se recuperan en otra función
func (service *PropiedadService) GetAllPropiedades() ([]*models.MenuPropiedades, error) {
	var propiedades []*models.MenuPropiedades
	query := "SELECT Propiedades.titulo, Propiedades.precio, Estado_Propiedades.tipo_transaccion, Estado_Propiedades.estado FROM Propiedades, Estado_Propiedades WHERE Propiedades.id_propiedad = Estado_Propiedades.id_propiedad"
	rows, err := service.DB.Query(query)
	if err != nil {
		if err == sql.ErrNoRows {
			log.Println("No rows found")
			return nil, nil
		}
		log.Println("Error fetching all propiedades:", err)
		return nil, err
	}
	defer rows.Close()

	for rows.Next() {
		var propiedad models.MenuPropiedades
		err := rows.Scan(&propiedad.Titulo, &propiedad.Precio, &propiedad.TipoTransaccion, &propiedad.Estado)
		if err != nil {
			log.Println("Error scanning propiedad:", err)
			return nil, err
		}
		propiedades = append(propiedades, &propiedad)
	}

	if err = rows.Err(); err != nil {
		log.Println("Error with rows:", err)
		return nil, err
	}
	return propiedades, nil
}

// /get/propiedad/:id
// Funcion que recupera todos los campos de una propiedad en específico
func (service *PropiedadService) GetPropiedad(id int) (*models.Propiedad, *models.EstadoPropiedades, error) {
	var propiedad models.Propiedad
	var estado models.EstadoPropiedades
	query := "SELECT * FROM Propiedades WHERE id_propiedad = ?"
	err := service.DB.QueryRow(query, id).Scan(&propiedad.IDPropiedad, &propiedad.Titulo, &propiedad.FechaAlta,
		&propiedad.Direccion, &propiedad.Colonia, &propiedad.Ciudad,
		&propiedad.Referencia, &propiedad.Precio, &propiedad.MtsConstruccion,
		&propiedad.MtsTerreno, &propiedad.Habitada, &propiedad.Amueblada,
		&propiedad.NumPlantas, &propiedad.NumRecamaras, &propiedad.NumBanos,
		&propiedad.SizeCochera, &propiedad.MtsJardin, &propiedad.Gas,
		&propiedad.Comodidades, &propiedad.Extras, &propiedad.Utilidades,
		&propiedad.Observaciones)
	if err != nil {
		if err == sql.ErrNoRows {
			log.Println("No rows found")
			return nil, nil, nil
		}
		log.Println("Error fetching propiedad:", err)
		return nil, nil, err
	}

	return &propiedad, &estado, nil
}

// get/propiedades/:id_tipo_propiedad
// Funcion que recupera el estado de la propiedad dependiedo del id_tipo_propiedad que biene en el get/prpopiedad/:id
func (service *PropiedadService) GetEstadoPropiedad(id int) (*models.EstadoPropiedades, error) {
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
