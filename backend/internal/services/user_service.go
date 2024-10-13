package services

import (
	"backend/internal/models"
	"database/sql"
	"errors"
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

// Function to retrieve a user by email and password
func (service *UserService) Login(email, password string) (*models.User, error) {
	user := &models.User{}
	query := "select * from Usuarios where usuario = ? and password_usuario = ?;"
	println(email, password)
	err := service.DB.QueryRow(query, email, password).Scan(&user.ID, &user.Email, &user.Password)
	println(err)
	if err != nil {
		if err == sql.ErrNoRows {
			return user, errors.New("invalid credentials")
		}
		return user, err
	}
	return user, nil
}
