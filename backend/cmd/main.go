package main

import (
	"backend/internal/controllers"
	"backend/internal/database"
	"backend/internal/services"

	"github.com/gin-gonic/gin"
)

func main() {
	// Initialize the database connection
	database.InitDB()

	// Initialize services
	userService := services.NewUserService(database.DB)
	PropiedadService := services.NewPropiedadService(database.DB)

	// Initialize controllers
	userController := controllers.NewUserController(userService)
	propiedadController := controllers.NewPropiedadController(PropiedadService)

	// Set up Gin router
	router := gin.Default()

	// Define routes

	// rutas para un usuario en específico
	router.GET("/users/:id", userController.GetUser)
	// ruta para comprobar credenciales de un usuario
	router.POST("/login", userController.Login)

	// ruta para agarrar la informacion importante de todas las propiedades
	router.GET("/all/propiedades/", propiedadController.GetAllPropiedades)
	// ruta para agarrar toda la informacion de una propiedad en específico
	router.GET("/propiedad/:id", propiedadController.GetPropiedad)
	// ruta para agarrar el estado de una propiedad en específico
	router.GET("/estadopropiedad/:id", propiedadController.GetTipoPropiedad)
	// ruta para agarrar el propietario de una propiedad en específico
	router.GET("/propietario/:id", propiedadController.GetPropietario)
	// ruta para agarrar el tipo de propiedad
	router.GET("/tipopropiedad/:id", propiedadController.GetTipoPropiedad)

	// Start the server
	router.Run(":8080")
}
