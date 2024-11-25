package models

// Contrato representa la estructura de la tabla Contratos.
type Contrato struct {
	IDContrato         	int    `json:"id_contrato"`
	DescripcionContrato string `json:"descripcion_contrato,omitempty"`
	Tipo               	string `json:"tipo,omitempty"`
	RutaPDF            	string `json:"ruta_pdf,omitempty"`
	IDPropiedad        	int    `json:"id_propiedad"`
}