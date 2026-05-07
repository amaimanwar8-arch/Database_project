const db = require('../config/db');

const getAllUsers = async (req, res) => {
  const [users] = await db.query("SELECT user_id, name, email, role, is_active FROM users");
  res.json(users);
};

const deleteUser = async (req, res) => {
  const { id } = req.params;
  await db.query("DELETE FROM users WHERE user_id = ?", [id]);
  await db.query("INSERT INTO admin_audit_log (admin_id, operation, details) VALUES (?, ?, ?)",
    [req.user.id, 'DELETE_USER', `Deleted user ${id}`]);
  res.json({ message: "User deleted" });
};

const getAuditLogs = async (req, res) => {
  const [logs] = await db.query("SELECT * FROM admin_audit_log ORDER BY created_at DESC");
  res.json(logs);
};

module.exports = { getAllUsers, deleteUser, getAuditLogs };