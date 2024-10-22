package services

import (
	"backend/internal/models"
	"database/sql"
	"log"
	"strings"
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
	var gas, comodidades, extras, utilidades string
	query := "SELECT * FROM Propiedades WHERE id_propiedad = ?"
	err := service.DB.QueryRow(query, id).Scan(&propiedad.IDPropiedad, &propiedad.Titulo, &propiedad.FechaAlta,
		&propiedad.Direccion, &propiedad.Colonia, &propiedad.Ciudad,
		&propiedad.Referencia, &propiedad.Precio, &propiedad.MtsConstruccion,
		&propiedad.MtsTerreno, &propiedad.Habitada, &propiedad.Amueblada,
		&propiedad.NumPlantas, &propiedad.NumRecamaras, &propiedad.NumBanos,
		&propiedad.SizeCochera, &propiedad.MtsJardin, &gas,
		&comodidades, &extras, &utilidades,
		&propiedad.Observaciones, &propiedad.IDTipoPropiedad, &propiedad.IDPropietario, &propiedad.IDUsuario)
	if err != nil {
		if err == sql.ErrNoRows {
			log.Println("No rows found")
			return nil, nil
		}
		log.Println("Error fetching propiedad:", err)
		return nil, err
	}

	propiedad.Gas = parseStringSet(gas)
	propiedad.Comodidades = parseStringSet(comodidades)
	propiedad.Extras = parseStringSet(extras)
	propiedad.Utilidades = parseStringSet(utilidades)

	return &propiedad, nil
}

func (service *PropiedadService) InsertPropiedad(propiedad *models.Propiedad) (int, error) {
	query := "INSERT INTO Propiedades(id_propiedad, titulo, fecha_alta, direccion, colonia, ciudad, referencia, " +
		"precio, mts_construccion, mts_terreno, habitada, amueblada, " +
		"num_plantas, num_recamaras, num_banos, size_cochera, mts_jardin, " +
		"gas, comodidades, extras, utilidades, observaciones, id_tipo_propiedad, " +
		"id_propietario, id_usuario) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)"
	result, err := service.DB.Exec(query, propiedad.IDPropiedad, propiedad.Titulo, propiedad.FechaAlta,
		propiedad.Direccion, propiedad.Colonia, propiedad.Ciudad, propiedad.Referencia,
		propiedad.Precio, propiedad.MtsConstruccion, propiedad.MtsTerreno, propiedad.Habitada, propiedad.Amueblada,
		propiedad.NumPlantas, propiedad.NumRecamaras, propiedad.NumBanos, propiedad.SizeCochera, propiedad.MtsJardin,
		strings.Join(propiedad.Gas, ","), strings.Join(propiedad.Comodidades, ","), strings.Join(propiedad.Extras, ","),
		strings.Join(propiedad.Utilidades, ","), propiedad.Observaciones, propiedad.IDTipoPropiedad, propiedad.IDPropietario, propiedad.IDUsuario)

	if err != nil {
		log.Println("Error inserting propiedad:", err)
		return 0, err
	} else {
		lastID, err := result.LastInsertId()
		if err != nil {
			log.Println("Error getting last insert ID:", err)
			return 0, err
		}
		return int(lastID), nil
	}
}

// helper function to parse sets of strings
func parseStringSet(str string) []string {
	var set []string
	if str != "" {
		set = strings.Split(str, ",")
	}
	return set
}
