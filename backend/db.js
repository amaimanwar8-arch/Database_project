const mysql = require('mysql2/promise');
require('dotenv').config();

let pool;

try {
  pool = mysql.createPool({
    host: process.env.DB_HOST || 'localhost',
    user: process.env.DB_USER || 'root',
    password: process.env.DB_PASS || '',
    database: process.env.DB_NAME || 'Movies_Management_System',
    waitForConnections: true,
    connectionLimit: 10,
    queueLimit: 0,
    enableKeepAlive: true,
    keepAliveInitialDelayMs: 0
  });
  
  console.log('✓ Database pool created successfully');
} catch (err) {
  console.error('✗ Database pool error:', err.message);
}

module.exports = pool;