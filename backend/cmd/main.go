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
	PropiedadService := services.NewPropiedadService(database.DB)
	EstadoPropiedadService := services.NewEstadoPropiedadService(database.DB)
	PropietarioService := services.NewPropietarioService(database.DB)
	TipoPropiedadService := services.NewTipoPropiedadService(database.DB)
	citasService := services.NewCitasService(database.DB)

	// Initialize controllers
	userController := controllers.NewUserController(userService)
	propiedadController := controllers.NewPropiedadController(PropiedadService, EstadoPropiedadService)
	estadoPropiedadController := controllers.NewEstadoPropiedadController(EstadoPropiedadService)
	propietarioController := controllers.NewPropietarioController(PropietarioService)
	tipoPropiedadController := controllers.NewTipoPropiedadController(TipoPropiedadService)
	citasController := controllers.NewCitasController(citasService)

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

	// rutas para un usuario en específico
	router.GET("/users/:id", userController.GetUser)
	// ruta para comprobar credenciales de un usuario
	router.POST("/login", userController.Login)

	// ruta para agarrar la informacion importante de todas las propiedades
	router.GET("/all/propiedades", propiedadController.GetAllPropiedades)
	// ruta para agarrar la informacion importante de todas las propiedades ordenadas por precio
	router.GET("/all/propiedadesByPrice", propiedadController.GetAllPropiedadesByPrice)
	// ruta para agarrar la informacion importante de todas las propiedades ordenadas por habitaciones
	router.GET("/all/propiedadesByBedrooms", propiedadController.GetAllPropiedades)
	// ruta para agarrar toda la informacion de una propiedad en específico
	router.GET("/propiedad/:id", propiedadController.GetPropiedad)
	// ruta para agarrar el estado de una propiedad en específico
	router.GET("/estadopropiedad/:id", estadoPropiedadController.GetEstadoPropiedad)
	// ruta para agarrar el propietario de una propiedad en específico
	router.GET("/propietario/:id", propietarioController.GetPropietario)
	// ruta para agarrar el tipo de propiedad
	router.GET("/tipopropiedad/:id", tipoPropiedadController.GetTipoPropiedad)
	// ruta para agarrar todas las citas de un usuario especifico
	router.GET("/all/citas/:id", citasController.GetAllCitas)
	// ruta para agarrar una cita en específico
	router.GET("/cita/:id", citasController.GetCita)

	// ruta para insertar una propiedad
	router.POST("/create/propiedad", propiedadController.CreatePropiedad)
	router.POST("/create/estadopropiedad", estadoPropiedadController.CreateEstadoPropiedad)
	router.POST("/create/propietario", propietarioController.CreatePropietario)
	router.POST("/create/tipoPropiedad", tipoPropiedadController.CreateTipoPropiedad)
	router.POST("/create/cita", citasController.InsertCita)

	// ruta para actualizar una propiedad
	router.PUT("/update/propiedad/:id", propiedadController.UpdatePropiedad)
	// router.PUT("/update/estadoPropiedad/:id", estadoPropiedadController.UpdateEstadoPropiedad)
	router.PUT("/update/cita", citasController.UpdateCita)

	// rutas para borrar una propiedad
	router.DELETE("/eliminar/propiedad/:id", propiedadController.DeletePropiedad)
	router.DELETE("/eliminar/estadoPropiedad/:id", estadoPropiedadController.DeleteEstadoPropiedad)
	router.DELETE("/eliminar/cita/:id", citasController.DeleteCita)

	// Start the server
	router.Run(":8080")
}
