package controllers

import (
	"backend/internal/services"
	"net/http"
	"strconv"

	"github.com/gin-gonic/gin"
)

// UserController is the controller for the User model
type Propiedad_Controller struct {
	PropiedadService *services.PropiedadService
}

// NewUserController is the constructor for the UserController
func NewPropiedadController(propiedadService *services.PropiedadService) *Propiedad_Controller {
	return &Propiedad_Controller{
		PropiedadService: propiedadService,
	}
}

// GET /all/propiedades/
func (ctrl *Propiedad_Controller) GetAllPropiedades(c *gin.Context) {
	propiedades, err := ctrl.PropiedadService.GetAllPropiedades()
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to retrieve propiedades"})
		return
	}

	if propiedades == nil {
		c.JSON(http.StatusNotFound, gin.H{"error": "No propiedades found"})
		return
	}

	c.JSON(http.StatusOK, propiedades)
}

// GET /propiedad/:id
func (ctrl *Propiedad_Controller) GetPropiedad(c *gin.Context) {
	idParam := c.Param("id")
	id, err := strconv.Atoi(idParam)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid propiedad ID"})
		return
	}

	propiedad, err := ctrl.PropiedadService.GetPropiedad(id)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to retrieve propiedad"})
		return
	}

	if propiedad == nil {
		c.JSON(http.StatusNotFound, gin.H{"error": "No propiedad found"})
		return
	}

	c.JSON(http.StatusOK, propiedad)
}

// GET /estadopropiedad/:id
func (ctrl *Propiedad_Controller) GetEstadoPropiedad(c *gin.Context) {
	idParam := c.Param("id")
	id, err := strconv.Atoi(idParam)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid propiedad ID"})
		return
	}

	estadoPropiedad, err := ctrl.PropiedadService.GetEstadoPropiedad(id)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to retrieve estado propiedad"})
		return
	}

	if estadoPropiedad == nil {
		c.JSON(http.StatusNotFound, gin.H{"error": "No estado propiedad found"})
		return
	}

	c.JSON(http.StatusOK, estadoPropiedad)
}

// GET /estadoPropiedad/:id
func (ctrl *Propiedad_Controller) GetTipoPropiedad(c *gin.Context) {
	idTipoPropiedadParam := c.Param("id")
	idTipoPropiedad, err := strconv.Atoi(idTipoPropiedadParam)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid tipo propiedad ID"})
		return
	}

	propiedades, err := ctrl.PropiedadService.GetTipoPropiedad(idTipoPropiedad)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to retrieve propiedades"})
		return
	}

	if propiedades == nil {
		c.JSON(http.StatusNotFound, gin.H{"error": "No propiedades found"})
		return
	}

	c.JSON(http.StatusOK, propiedades)
}

// GET /propietario/:id_propietario
func (ctrl *Propiedad_Controller) GetPropietario(c *gin.Context) {
	idPropietarioParam := c.Param("id")
	idPropietario, err := strconv.Atoi(idPropietarioParam)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid propietario ID"})
		return
	}

	propietario, err := ctrl.PropiedadService.GetPropietario(idPropietario)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to retrieve propietario"})
		return
	}

	if propietario == nil {
		c.JSON(http.StatusNotFound, gin.H{"error": "No propietario found"})
		return
	}

	c.JSON(http.StatusOK, propietario)
}
