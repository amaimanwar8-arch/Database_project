const express = require('express');
const { verifyToken, isAdmin } = require('../middleware/auth');
const { getAllUsers, deleteUser, getAuditLogs } = require('../controllers/adminController');

const router = express.Router();
router.use(verifyToken);
router.use(isAdmin);

router.get('/users', getAllUsers);
router.delete('/users/:id', deleteUser);
router.get('/audit-logs', getAuditLogs);

module.exports = router;