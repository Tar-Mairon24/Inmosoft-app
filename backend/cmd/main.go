package main

import (
    "github.com/gin-gonic/gin"
    "net/http"
)

func main() {
    // Initialize Gin router
    router := gin.Default()

    // Define a simple GET route
    router.GET("/ping", func(c *gin.Context) {
        c.JSON(http.StatusOK, gin.H{
            "message": "pong",
        })
    })

    // Start the server on port 8080
    router.Run(":8080")
}
