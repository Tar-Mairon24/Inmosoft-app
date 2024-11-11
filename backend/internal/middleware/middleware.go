package middleware

import (
    "net/http"
    "strconv"

    "github.com/gin-gonic/gin"
)

func UserIDMiddleware() gin.HandlerFunc {
    return func(c *gin.Context) {
        userIDStr := c.GetHeader("User-ID")
        if userIDStr == "" {
            c.JSON(http.StatusBadRequest, gin.H{"error": "User ID header is missing"})
            c.Abort()
            return
        }

        userID, err := strconv.Atoi(userIDStr)
        if err != nil {
            c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid User ID"})
            c.Abort()
            return
        }

        // Set the user ID in the context
        c.Set("userID", userID)

        // Continue to the next handler
        c.Next()
    }
}