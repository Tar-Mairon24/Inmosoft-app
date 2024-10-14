package controllers

import (
	"backend/internal/services"
	"net/http"

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
