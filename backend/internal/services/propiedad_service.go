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

// GET /propiedad/:id
// Funcion que recupera todos los campos de una propiedad en específico
func (service *PropiedadService) GetPropiedad(id int) (*models.Propiedad, error) {
	var propiedad models.Propiedad
	query := "SELECT * FROM Propiedades WHERE id_propiedad = ?"
	err := service.DB.QueryRow(query, id).Scan(&propiedad.IDPropiedad, &propiedad.Titulo, &propiedad.FechaAlta,
		&propiedad.Direccion, &propiedad.Colonia, &propiedad.Ciudad,
		&propiedad.Referencia, &propiedad.Precio, &propiedad.MtsConstruccion,
		&propiedad.MtsTerreno, &propiedad.Habitada, &propiedad.Amueblada,
		&propiedad.NumPlantas, &propiedad.NumRecamaras, &propiedad.NumBanos,
		&propiedad.SizeCochera, &propiedad.MtsJardin, &propiedad.Gas,
		&propiedad.Comodidades, &propiedad.Extras, &propiedad.Utilidades,
		&propiedad.Observaciones, &propiedad.IDTipoPropiedad, &propiedad.IDPropietario, &propiedad.IDUsuario)
	if err != nil {
		if err == sql.ErrNoRows {
			log.Println("No rows found")
			return nil, nil
		}
		log.Println("Error fetching propiedad:", err)
		return nil, err
	}

	return &propiedad, nil
}

// GET /estadoPropiedad/:id_tipo_propiedad
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

// /propietario/:id_propietario
// Funcion que recupera el propietario de la propiedad dependiendo del id_propietario que biene en el get/prpopiedad/:id
func (service *PropiedadService) GetPropietario(id int) (*models.Propietario, error) {
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

// GET /tipoPropiedad/:id_tipo_propiedad
// Funcion que recupera el tipo de propiedad dependiendo del id_tipo_propiedad que biene en el get/prpopiedad/:id
func (service *PropiedadService) GetTipoPropiedad(id int) (*models.TipoPropiedad, error) {
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
