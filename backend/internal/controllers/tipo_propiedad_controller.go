package controllers

import (
	"backend/internal/services"
	"net/http"
	"strconv"

	"github.com/gin-gonic/gin"
)

// TipoPropiedadController is the controller for the TipoPropiedad model
type TipoPropiedadController struct {
	TipoPropiedadService *services.TipoPropiedadService
}

// NewTipoPropiedadController is the constructor for the TipoPropiedadController
func NewTipoPropiedadController(tipoPropiedadService *services.TipoPropiedadService) *TipoPropiedadController {
	return &TipoPropiedadController{
		TipoPropiedadService: tipoPropiedadService,
	}
}

// GET /TipoPropiedad/:id
func (ctrl *TipoPropiedadController) GetTipoPropiedad(c *gin.Context) {
	idTipoPropiedadParam := c.Param("id")
	idTipoPropiedad, err := strconv.Atoi(idTipoPropiedadParam)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid tipo propiedad ID"})
		return
	}

	propiedades, err := ctrl.TipoPropiedadService.GetTipoPropiedad(idTipoPropiedad)
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