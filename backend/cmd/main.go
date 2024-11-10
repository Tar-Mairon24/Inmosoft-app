package main

import (
	"backend/internal/controllers"
	"backend/internal/database"
	"backend/internal/services"

	"github.com/gin-contrib/cors"
	"github.com/gin-gonic/gin"
)

func main() {
	// Initialize the database connection
	database.InitDB()

	// Initialize services
	userService := services.NewUserService(database.DB)
	propiedadService := services.NewPropiedadService(database.DB)
	estadoPropiedadService := services.NewEstadoPropiedadService(database.DB)
	propietarioService := services.NewPropietarioService(database.DB)
	tipoPropiedadService := services.NewTipoPropiedadService(database.DB)
	citasService := services.NewCitasService(database.DB)
	prospectoService := services.NewProspectoService(database.DB) // Nuevo servicio para Prospecto

	// Initialize controllers
	userController := controllers.NewUserController(userService)
	propiedadController := controllers.NewPropiedadController(propiedadService, estadoPropiedadService)
	estadoPropiedadController := controllers.NewEstadoPropiedadController(estadoPropiedadService)
	propietarioController := controllers.NewPropietarioController(propietarioService)
	tipoPropiedadController := controllers.NewTipoPropiedadController(tipoPropiedadService)
	citasController := controllers.NewCitasController(citasService)
	prospectoController := controllers.NewProspectoController(prospectoService) // Nuevo controlador para Prospecto

	// Set up Gin router
	router := gin.Default()

	router.Use(cors.New(cors.Config{
		AllowOrigins:     []string{"*"},
		AllowMethods:     []string{"GET", "POST", "PUT", "DELETE"},
		AllowHeaders:     []string{"Origin", "Content-Type", "Accept", "Authorization"},
		ExposeHeaders:    []string{"Content-Length"},
		AllowCredentials: true,
	}))

	// Set the Content-Type header to application/json; charset=utf-8
	router.Use(func(c *gin.Context) {
		c.Writer.Header().Set("Content-Type", "application/json; charset=utf-8")
		c.Next()
	})

	router.RemoveExtraSlash = true

	// Define routes

	// Rutas para usuarios
	router.GET("/users/:id", userController.GetUser)
	router.POST("/login", userController.Login)

	// Rutas para propiedades y sus estados
	router.GET("/all/propiedades", propiedadController.GetAllPropiedades)
	router.GET("/propiedad/:id", propiedadController.GetPropiedad)
	router.GET("/estadopropiedad/:id", estadoPropiedadController.GetEstadoPropiedad)
	router.GET("/propietario/:id", propietarioController.GetPropietario)
	router.GET("/tipopropiedad/:id", tipoPropiedadController.GetTipoPropiedad)
	router.GET("/all/citas/:id", citasController.GetAllCitas)
	router.GET("/cita/:id", citasController.GetCita)

	// Rutas de creación
	router.POST("/create/propiedad", propiedadController.CreatePropiedad)
	router.POST("/create/propietario", propietarioController.CreatePropietario)
	router.POST("/create/tipoPropiedad", tipoPropiedadController.CreateTipoPropiedad)
	router.POST("/create/cita", citasController.InsertCita)

	// Rutas de actualización
	router.PUT("/update/propiedad/:id", propiedadController.UpdatePropiedad)
	router.PUT("/update/estadoPropiedad/:id", estadoPropiedadController.UpdateEstadoPropiedad)
	router.PUT("/update/cita", citasController.UpdateCita)

	// Rutas de eliminación
	router.DELETE("/eliminar/propiedad/:id", propiedadController.DeletePropiedad)
	router.DELETE("/eliminar/estadoPropiedad/:id", estadoPropiedadController.DeleteEstadoPropiedad)
	router.DELETE("/eliminar/cita/:id", citasController.DeleteCita)

	// Rutas para prospectos
	router.GET("/all/prospectos", prospectoController.GetAllProspectos)         // Obtener todos los prospectos
	router.GET("/prospecto/:id", prospectoController.GetProspecto)              // Obtener un prospecto específico
	router.POST("/create/prospecto", prospectoController.CreateProspecto)       // Crear un prospecto
	router.PUT("/update/prospecto/:id", prospectoController.UpdateProspecto)    // Actualizar un prospecto
	router.DELETE("/delete/prospecto/:id", prospectoController.DeleteProspecto) // Eliminar un prospecto

	// Start the server
	router.Run(":8080")
}
