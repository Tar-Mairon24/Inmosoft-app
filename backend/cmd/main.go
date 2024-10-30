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

	// Initialize controllers
	userController := controllers.NewUserController(userService)
	propiedadController := controllers.NewPropiedadController(PropiedadService, EstadoPropiedadService)
	estadoPropiedadController := controllers.NewEstadoPropiedadController(EstadoPropiedadService)
	propietarioController := controllers.NewPropietarioController(PropietarioService)
	tipoPropiedadController := controllers.NewTipoPropiedadController(TipoPropiedadService)

	// Set up Gin router
	router := gin.Default()

	router.Use(cors.New(cors.Config{
		AllowOrigins:     []string{"*"},
		AllowMethods:     []string{"GET", "POST", "PUT", "DELETE"},
		AllowHeaders:     []string{"Origin", "Content-Type", "Accept", "Authorization"},
		ExposeHeaders:    []string{"Content-Length"},
		AllowCredentials: true,
	}))

	router.RemoveExtraSlash = true

	// Define routes

	// rutas para un usuario en específico
	router.GET("/users/:id", userController.GetUser)
	// ruta para comprobar credenciales de un usuario
	router.POST("/login", userController.Login)

	// ruta para agarrar la informacion importante de todas las propiedades
	router.GET("/all/propiedades", propiedadController.GetAllPropiedades)
	// ruta para agarrar toda la informacion de una propiedad en específico
	router.GET("/propiedad/:id", propiedadController.GetPropiedad)
	// ruta para agarrar el estado de una propiedad en específico
	router.GET("/estadopropiedad/:id", estadoPropiedadController.GetEstadoPropiedad)
	// ruta para agarrar el propietario de una propiedad en específico
	router.GET("/propietario/:id", propietarioController.GetPropietario)
	// ruta para agarrar el tipo de propiedad
	router.GET("/tipopropiedad/:id", tipoPropiedadController.GetTipoPropiedad)


	// ruta para insertar una propiedad
	router.POST("/create/propiedad", propiedadController.CreatePropiedad)
	//router.POST("/create/estadopropiedad", estadoPropiedadController.CreateEstadoPropiedad)
	router.POST("/create/propietario", propietarioController.CreatePropietario)
	router.POST("/create/tipoPropiedad", tipoPropiedadController.CreateTipoPropiedad)

	// ruta para actualizar una propiedad
	router.PUT("/update/propiedad/:id", propiedadController.UpdatePropiedad)
	router.PUT("/update/estadoPropiedad/:id", estadoPropiedadController.UpdateEstadoPropiedad)

	// rutas para borrar una propiedad
	router.DELETE("/eliminar/propiedad/:id", propiedadController.DeletePropiedad)
	//router.DELETE("/eliminar/estadoPropiedad/:id", estadoPropiedadController.DeleteEstadoPropiedad)

	// Start the server
	router.Run(":8080")
}
