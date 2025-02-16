const express = require('express');
const mongoose = require('mongoose');
require('dotenv').config();

const app = express();

// Middleware
app.use(express.json());

// MongoDB connection
mongoose.connect(process.env.MONGODB_URI)
  .then(() => console.log('Connected to MongoDB'))
  .catch((err) => console.error('MongoDB connection error:', err));

// Root route
app.get('/', (req, res) => {
  res.json({
    message: 'Welcome to the Todo API',
    endpoints: {
      'GET /todos': 'Get all todos',
      'GET /todos/{id}': 'Get a single todo',
      'POST /todos': 'Create a new todo',
      'PUT /todos/{id}': 'Update a todo',
      'DELETE /todos/{id}': 'Delete a todo'
    }
  });
});

// Routes
const todoRoutes = require('./routes/todos');
app.use('/todos', todoRoutes);

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});