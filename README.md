# HorrorVerse
## Full-Stack Horror Movie Database Web Application

## Overview

HorrorVerse is a full-stack movie web application developed as a Database Systems project. The platform is designed for horror movie enthusiasts to explore movies, manage user accounts, and interact with movie-related content through a modern web interface backed by a relational database system.

The project integrates frontend development, backend APIs, authentication systems, and database management into a complete full-stack application.

---

# Features

## User Features

- User Registration and Login
- Secure Authentication System
- Browse Horror Movies
- View Movie Details
- User Account Management
- Search and Navigation Functionality

---

## Admin Features

- Admin Authentication
- Manage Movie Records
- Update Movie Information
- Delete Existing Records
- Database Management Operations

---

# Tech Stack

## Frontend
- HTML
- CSS
- JavaScript

## Backend
- Node.js
- Express.js

## Database
- MySQL

## Authentication & Security
- JWT Authentication
- bcrypt Password Hashing

---

# Project Architecture

```text
Frontend  →  Backend API  →  MySQL Database
```

The frontend communicates with REST APIs built using Express.js, while MySQL manages persistent movie and user data.

---

# Database Design

The project uses a relational database system for managing:

- Users
- Movies
- Admin Records
- Authentication Data

The database schema is included in:

```bash
database/horrorverse.sql
```

# Backend Setup

Navigate to backend folder:

```bash
cd backend
```

Install dependencies:

```bash
npm install
```

Create a `.env` file:

```env
PORT=5000
DB_HOST=localhost
DB_USER=your_mysql_username
DB_PASSWORD=your_mysql_password
DB_NAME=horrorverse
JWT_SECRET=your_secret_key
```

Start backend server:

```bash
npm start
```

---

# Database Setup

1. Open MySQL
2. Create a database named:

```sql
CREATE DATABASE horrorverse;
```

3. Import the SQL file:

```bash
database/horrorverse.sql
```

---

# Frontend Setup

Open the frontend folder and run the application using Live Server or your preferred frontend setup.

---


# Learning Outcomes

This project helped in understanding:

- Full-stack web development
- REST API development
- Relational database design
- Authentication systems
- Backend architecture
- Database integration
- CRUD operations
- Client-server communication

---

# Future Improvements

- Add recommendation system
- Implement responsive mobile UI
- Add trailer integration
- Deploy application online

---

# Technologies Used

- Node.js
- Express.js
- MySQL
- JavaScript
- HTML
- CSS
- JWT
- bcrypt

---

# Author

Amaim Anwar 
BS Data Science  
FAST National University of Computer and Emerging Sciences

