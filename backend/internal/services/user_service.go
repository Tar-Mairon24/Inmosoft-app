package services

import (
	"backend/internal/models"
	"database/sql"
	"log"
)

type UserService struct {
	DB *sql.DB
}

// Constructor for the UserService
func NewUserService(db *sql.DB) *UserService {
	return &UserService{
		DB: db,
	}
}

// Function to retrieve a user by ID
func (service *UserService) GetUserByID(id int) (*models.User, error) {
	user := &models.User{}
	query := "SELECT * FROM Usuarios WHERE id_usuario = ?"
	err := service.DB.QueryRow(query, id).Scan(&user.ID, &user.Email, &user.Password)
	if err != nil {
		if err == sql.ErrNoRows {
			return nil, nil
		}
		log.Println("Error fetching user by ID:", err)
		return nil, err
	}
	return user, nil
}
