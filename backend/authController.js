const db = require('../config/db');
const jwt = require('jsonwebtoken');
const bcrypt = require('bcryptjs');

const register = async (req, res) => {
  try {
    console.log('📝 Register request received:', req.body);
    
    const { name, email, password, dob, location, role } = req.body;

    // Validation
    if (!name || !email || !password) {
      console.log('❌ Missing required fields');
      return res.status(400).json({ error: "Name, email, and password are required" });
    }

    // Determine role (default to 'user' unless explicitly 'admin')
    const userRole = role === 'admin' ? 'admin' : 'user';

    console.log('🔍 Checking if email already exists...');
    // Check if email already exists
    const [existingUser] = await db.query("SELECT user_id FROM users WHERE email = ?", [email]);
    if (existingUser.length > 0) {
      console.log('❌ Email already exists:', email);
      return res.status(409).json({ error: "Email already registered" });
    }

    console.log('🔐 Hashing password...');
    // Hash password
    const hashedPassword = await bcrypt.hash(password, 10);

    console.log('💾 Inserting user into database...');
    // Insert user with specified role
    const [result] = await db.query(
      "INSERT INTO users (name, email, password_hash, role) VALUES (?, ?, ?, ?)",
      [name, email, hashedPassword, userRole]
    );

    console.log('✅ User created with ID:', result.insertId);

    // Insert user profile if dob is provided
    if (dob) {
      console.log('📅 Creating user profile...');
      await db.query(
        "INSERT INTO user_profile (user_id, dob, location) VALUES (?, ?, ?)",
        [result.insertId, dob, location || null]
      );
      console.log('✅ User profile created');
    }

    console.log('🎉 Registration successful for:', email, 'with role:', userRole);
    res.status(201).json({ 
      message: "Registration successful",
      userId: result.insertId,
      role: userRole
    });
  } catch (err) {
    console.error('❌ REGISTER ERROR:', err);
    console.error('Error message:', err.message);
    console.error('Error code:', err.code);
    res.status(500).json({ error: "Server error: " + err.message });
  }
};

const login = async (req, res) => {
  try {
    console.log('🔑 Login request received:', req.body.email);

    const { email, password } = req.body;

    if (!email || !password) {
      console.log('❌ Missing email or password');
      return res.status(400).json({ error: "Email and password required" });
    }

    console.log('🔍 Finding user...');
    // Find user by email
    const [rows] = await db.query("SELECT * FROM users WHERE email = ?", [email]);
    
    if (rows.length === 0) {
      console.log('❌ User not found:', email);
      return res.status(401).json({ error: "Invalid email or password" });
    }

    const user = rows[0];
    console.log('✅ User found:', user.name);

    console.log('🔐 Comparing passwords...');
    // Compare passwords
    const passwordMatch = await bcrypt.compare(password, user.password_hash);
    if (!passwordMatch) {
      console.log('❌ Password mismatch');
      return res.status(401).json({ error: "Invalid email or password" });
    }

    console.log('🎫 Generating JWT token...');
    // Generate JWT token
    const token = jwt.sign(
      { id: user.user_id, role: user.role },
      process.env.JWT_SECRET || 'your_secret_key',
      { expiresIn: '7d' }
    );

    console.log('✅ Login successful for:', email);
    res.json({
      message: "Login successful",
      token,
      user: {
        id: user.user_id,
        name: user.name,
        email: user.email,
        role: user.role
      }
    });
  } catch (err) {
    console.error('❌ LOGIN ERROR:', err);
    console.error('Error message:', err.message);
    console.error('Error code:', err.code);
    res.status(500).json({ error: "Server error: " + err.message });
  }
};

module.exports = { register, login };
