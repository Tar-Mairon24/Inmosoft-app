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

	// Initialize controllers
	userController := controllers.NewUserController(userService)

	// Set up Gin router
	router := gin.Default()

	// Define routes
	router.GET("/users/:id", userController.GetUser)
	router.POST("/login", userController.Login)

	// Start the server
	router.Run(":8080")
}
