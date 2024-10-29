package controllers

import (
	"backend/internal/models"
	"backend/internal/services"
	"net/http"
	"strconv"
	"log"

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

// POST /propiedad/
func (ctrl *Propiedad_Controller) CreatePropiedad(c *gin.Context) {
	var propiedad models.Propiedad
	if err := c.ShouldBindJSON(&propiedad); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid request payload"})
		return
	}

	id, err := ctrl.PropiedadService.InsertPropiedad(&propiedad)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to insert propiedad"})
		return
	}
	log.Printf("Propiedad created with ID: %d", id)

	c.JSON(http.StatusCreated, propiedad)
}

// PUT /propiedad/:id
func (ctrl *Propiedad_Controller) UpdatePropiedad(c *gin.Context) {
	idParam := c.Param("id")
	id, err := strconv.Atoi(idParam)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid propiedad ID"})
		return
	}

	var propiedad models.Propiedad
	if err := c.ShouldBindJSON(&propiedad); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid request payload"})
		return
	}

	propiedad.IDPropiedad = id
	err = ctrl.PropiedadService.UpdatePropiedad(&propiedad)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to update propiedad"})
		return
	}

	c.JSON(http.StatusOK, propiedad)
}

// DELETE eliminar/propiedad/:id
func (ctrl *Propiedad_Controller) DeletePropiedad(c *gin.Context) {
	idParam := c.Param("id")
	id, err := strconv.Atoi(idParam)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid propiedad ID"})
		return
	}

	err = ctrl.PropiedadService.DeletePropiedad(id)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to delete propiedad"})
		return
	}

	c.JSON(http.StatusOK, gin.H{"message": "Propiedad deleted"})
}
