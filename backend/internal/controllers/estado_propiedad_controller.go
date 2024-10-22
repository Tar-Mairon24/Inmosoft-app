package controllers

import (
	"backend/internal/services"
	"net/http"
	"strconv"

	"github.com/gin-gonic/gin"
)

type EstadoPropiedadController struct {
	EstadoPropiedadService *services.EstadoPropiedadService
}

func NewEstadoPropiedadController(estadoPropiedadService *services.EstadoPropiedadService) *EstadoPropiedadController {
	return &EstadoPropiedadController{
		EstadoPropiedadService: estadoPropiedadService,
	}
}

// GET /estadopropiedad/:id
func (ctrl *EstadoPropiedadController) GetEstadoPropiedad(c *gin.Context) {
	idParam := c.Param("id")
	id, err := strconv.Atoi(idParam)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid propiedad ID"})
		return
	}

	estadoPropiedad, err := ctrl.EstadoPropiedadService.GetEstadoPropiedad(id)
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

