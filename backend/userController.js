const db = require('../config/db');

const getProfile = async (req, res) => {
  const [[user]] = await db.query(
    `SELECT u.*, p.dob, p.location FROM users u 
     LEFT JOIN user_profile p ON u.user_id = p.user_id 
     WHERE u.user_id = ?`, [req.user.id]
  );
  res.json(user);
};

const getMovies = async (req, res) => {
  const [movies] = await db.query("SELECT * FROM movie ORDER BY created_at DESC");
  res.json(movies);
};

const getPosts = async (req, res) => {
  const [posts] = await db.query(
    `SELECT p.*, u.name as author FROM post p 
     JOIN users u ON p.user_id = u.user_id 
     ORDER BY p.created_at DESC`
  );
  res.json(posts);
};

const getFavorites = async (req, res) => {
  const [favs] = await db.query(
    `SELECT m.* FROM movie m 
     JOIN favorite f ON m.movie_id = f.movie_id 
     WHERE f.user_id = ?`, [req.user.id]
  );
  res.json(favs);
};

const addFavorite = async (req, res) => {
  const { movie_id } = req.body;
  await db.query("INSERT IGNORE INTO favorite (user_id, movie_id) VALUES (?, ?)", [req.user.id, movie_id]);
  res.json({ message: "Added to favorites" });
};

const getEvents = async (req, res) => {
  const [events] = await db.query("SELECT * FROM event ORDER BY event_date DESC");
  res.json(events);
};

// Notification functions
const getNotifications = async (req, res) => {
  try {
    console.log('📬 Getting notifications for user:', req.user.id);
    
    const [notifications] = await db.query(
      `SELECT * FROM notification 
       WHERE user_id = ?
       ORDER BY created_at DESC`,
      [req.user.id]
    );

    console.log('✅ Retrieved', notifications.length, 'notifications');
    res.json(notifications);
  } catch (err) {
    console.error('❌ GET NOTIFICATIONS ERROR:', err.message);
    res.status(500).json({ error: "Server error: " + err.message });
  }
};

const markNotificationAsRead = async (req, res) => {
  try {
    const { notificationId } = req.params;
    
    console.log('📖 Marking notification', notificationId, 'as read');
    
    await db.query(
      `UPDATE notification SET is_read = true 
       WHERE notification_id = ? AND user_id = ?`,
      [notificationId, req.user.id]
    );

    console.log('✅ Notification marked as read');
    res.json({ message: "Notification marked as read" });
  } catch (err) {
    console.error('❌ MARK AS READ ERROR:', err.message);
    res.status(500).json({ error: "Server error" });
  }
};

const markAllNotificationsAsRead = async (req, res) => {
  try {
    console.log('📖 Marking all notifications as read for user:', req.user.id);
    
    await db.query(
      `UPDATE notification SET is_read = true 
       WHERE user_id = ?`,
      [req.user.id]
    );

    console.log('✅ All notifications marked as read');
    res.json({ message: "All notifications marked as read" });
  } catch (err) {
    console.error('❌ MARK ALL ERROR:', err.message);
    res.status(500).json({ error: "Server error" });
  }
};

const deleteNotification = async (req, res) => {
  try {
    const { notificationId } = req.params;
    
    console.log('🗑️ Deleting notification:', notificationId);
    
    await db.query(
      `DELETE FROM notification 
       WHERE notification_id = ? AND user_id = ?`,
      [notificationId, req.user.id]
    );

    console.log('✅ Notification deleted');
    res.json({ message: "Notification deleted" });
  } catch (err) {
    console.error('❌ DELETE ERROR:', err.message);
    res.status(500).json({ error: "Server error" });
  }
};

const deleteAllNotifications = async (req, res) => {
  try {
    console.log('🗑️ Deleting all notifications for user:', req.user.id);
    
    await db.query(
      `DELETE FROM notification WHERE user_id = ?`,
      [req.user.id]
    );

    console.log('✅ All notifications deleted');
    res.json({ message: "All notifications deleted" });
  } catch (err) {
    console.error('❌ DELETE ALL ERROR:', err.message);
    res.status(500).json({ error: "Server error" });
  }
};

module.exports = {
  getProfile, 
  getMovies, 
  getPosts, 
  getFavorites, 
  addFavorite, 
  getEvents,
  getNotifications,
  markNotificationAsRead,
  markAllNotificationsAsRead,
  deleteNotification,
  deleteAllNotifications
};