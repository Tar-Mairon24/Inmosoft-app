package controllers

import (
	"backend/internal/models"
	"backend/internal/services"
	"net/http"
	"strconv"

	"github.com/gin-gonic/gin"
)

// ProspectoController es el controlador para el modelo Prospecto
type ProspectoController struct {
	ProspectoService *services.ProspectoService
}

// NewProspectoController es el constructor para el ProspectoController
func NewProspectoController(prospectoService *services.ProspectoService) *ProspectoController {
	return &ProspectoController{
		ProspectoService: prospectoService,
	}
}

// GET /all/prospectos
func (ctrl *ProspectoController) GetAllProspectos(c *gin.Context) {
	prospectos, err := ctrl.ProspectoService.GetAllProspectos()
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to retrieve prospectos"})
		return
	}

	if prospectos == nil {
		c.JSON(http.StatusNotFound, gin.H{"error": "No prospectos found"})
		return
	}

	c.JSON(http.StatusOK, prospectos)
}

// GET /prospecto/:id
func (ctrl *ProspectoController) GetProspecto(c *gin.Context) {
	idParam := c.Param("id")
	id, err := strconv.Atoi(idParam)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid prospecto ID"})
		return
	}

	prospecto, err := ctrl.ProspectoService.GetProspecto(id)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to retrieve prospecto"})
		return
	}

	if prospecto == nil {
		c.JSON(http.StatusNotFound, gin.H{"error": "No prospecto found"})
		return
	}

	c.JSON(http.StatusOK, prospecto)
}

// POST /prospecto
func (ctrl *ProspectoController) CreateProspecto(c *gin.Context) {
	var prospecto models.Prospecto

	if err := c.ShouldBindJSON(&prospecto); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid request payload", "details": err.Error()})
		return
	}

	IDProspecto, err := ctrl.ProspectoService.CreateProspecto(&prospecto)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to create prospecto", "details": err.Error()})
		return
	}

	c.JSON(http.StatusCreated, gin.H{"id_cliente": IDProspecto})
}

// PUT /prospecto/:id
func (ctrl *ProspectoController) UpdateProspecto(c *gin.Context) {
	idParam := c.Param("id")
	id, err := strconv.Atoi(idParam)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid prospecto ID"})
		return
	}

	var prospecto models.Prospecto
	if err := c.ShouldBindJSON(&prospecto); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid request payload"})
		return
	}

	err = ctrl.ProspectoService.UpdateProspecto(&prospecto, id)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to update prospecto"})
		return
	}

	c.JSON(http.StatusOK, prospecto)
}

// DELETE /prospecto/:id
func (ctrl *ProspectoController) DeleteProspecto(c *gin.Context) {
	idParam := c.Param("id")
	id, err := strconv.Atoi(idParam)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid prospecto ID"})
		return
	}

	err = ctrl.ProspectoService.DeleteProspecto(id)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to delete prospecto"})
		return
	}

	c.JSON(http.StatusOK, gin.H{"message": "Prospecto deleted"})
}
