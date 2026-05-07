const express = require('express');
const { verifyToken } = require('../middleware/auth');
const { getProfile, getMovies, getPosts, getFavorites, addFavorite, getEvents, getNotifications, markNotificationAsRead, markAllNotificationsAsRead, deleteNotification, deleteAllNotifications } = require('../controllers/userController');
const router = express.Router();
router.use(verifyToken);

router.get('/profile', getProfile);
router.get('/movies', getMovies);
router.get('/posts', getPosts);
router.get('/favorites', getFavorites);
router.post('/favorites', addFavorite);
router.get('/events', getEvents);

// Notification routes
router.get('/notifications', getNotifications);
router.put('/notifications/:notificationId/read', markNotificationAsRead);
router.put('/notifications/read/all', markAllNotificationsAsRead);
router.delete('/notifications/:notificationId', deleteNotification);
router.delete('/notifications/delete/all', deleteAllNotifications);

module.exports = router;