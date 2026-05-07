const express = require('express');
const cors = require('cors');
const path = require('path');
require('dotenv').config();

const app = express();

// These three lines serve ALL your HTML files perfectly
app.use(cors());
app.use(express.json());
app.use(express.static(path.join(__dirname, '../frontend')));

// API Routes — MUST come before any catch-all
app.use('/api/auth', require('./routes/auth'));
app.use('/api/user', require('./routes/user'));
app.use('/api/admin', require('./routes/admin'));



const PORT = process.env.PORT || 5000;
app.listen(PORT, () => {
  console.log(`HORRORVERSE 100% WORKING → http://localhost:${PORT}`);
});