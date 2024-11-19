package controllers

import (
	"backend/internal/models"
	"backend/internal/services"
	"fmt"
	"net/http"
	"strconv"

	"github.com/gin-gonic/gin"
)

// UserController is the controller for the User model
type CitasController struct {
	CitasService *services.CitasService
}

// NewUserController is the constructor for the UserController
func NewCitasController(citasService *services.CitasService) *CitasController {
	return &CitasController{
		CitasService: citasService,
	}
}

// GET /all/citas/:id)user
func (ctrl *CitasController) GetAllCitas(c *gin.Context) {
	idParam := c.Param("id")
	id, err := strconv.Atoi(idParam)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid user ID"})
		return
	}

	citas, err := ctrl.CitasService.GetAllCitasUser(id)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to retrieve citas"})
		return
	}

	if citas == nil {
		c.JSON(http.StatusNotFound, gin.H{"error": "No citas found"})
		return
	}

	c.Header("Content-Type", "application/json; charset=utf-8")
	c.JSON(http.StatusOK, citas)
}

// GET /cita/:id
func (ctrl *CitasController) GetCita(c *gin.Context) {
	idParam := c.Param("id")
	id, err := strconv.Atoi(idParam)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid cita ID"})
		return
	}

	cita, err := ctrl.CitasService.GetCita(id)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to retrieve cita"})
		return
	}

	if cita == nil {
		c.JSON(http.StatusNotFound, gin.H{"error": "Cita not found"})
		return
	}

	c.JSON(http.StatusOK, cita)
}

// POST /citas
func (ctrl *CitasController) InsertCita(c *gin.Context) {
	// var cita models.Cita
	var request struct {
		Cita      models.Cita      `json:"cita"`
		Prospecto models.Prospecto `json:"prospecto"`
	}

	fmt.Printf("Request payload before binding: %+v\n", request)
	if err := c.ShouldBindJSON(&request); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid request payload", "details": err.Error()})
		print(err.Error())
		return
	}

	fmt.Printf("Request payload after binding: %+v\n", request)

	IDCita, IDProspecto, err := ctrl.CitasService.InsertCita(&request.Cita, &request.Prospecto)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to create propiedad", "details": err.Error()})
		return
	}

	c.JSON(http.StatusCreated, gin.H{"id_cita": IDCita, "id_cliente": IDProspecto})
}

// PUT /citas
func (ctrl *CitasController) UpdateCita(c *gin.Context) {
	var cita models.Cita
	if err := c.ShouldBindJSON(&cita); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid input"})
		return
	}

	if err := ctrl.CitasService.UpdateCita(&cita); err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to update cita"})
		return
	}

	c.JSON(http.StatusOK, cita)
}

// DELETE /citas/:id
func (ctrl *CitasController) DeleteCita(c *gin.Context) {
	idParam := c.Param("id")
	id, err := strconv.Atoi(idParam)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid cita ID"})
		return
	}

	if err := ctrl.CitasService.DeleteCita(id); err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to delete cita"})
		return
	}

	c.JSON(http.StatusOK, gin.H{"message": "Cita deleted"})
}
