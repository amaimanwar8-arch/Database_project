// ============================================
// SHARED HORRORVERSE FUNCTIONS
// Include this file in all HTML pages: <script src="shared-functions.js"></script>
// ============================================

// Initialize global HorrorVerse object
window.HorrorVerse = window.HorrorVerse || {};

// ============================================
// FAVORITES MANAGEMENT
// ============================================

function getFavorites() {
  const stored = localStorage.getItem('horrorverse_favorites');
  return stored ? JSON.parse(stored) : [];
}

function addToFavorites(movie) {
  const favorites = getFavorites();
  
  // Check if already exists
  const exists = favorites.some(fav => fav.id === movie.id);
  
  if (!exists) {
    favorites.push(movie);
    localStorage.setItem('horrorverse_favorites', JSON.stringify(favorites));
    return { success: true, message: 'Added to favorites' };
  }
  
  return { success: false, message: 'Already in favorites' };
}

function removeFromFavorites(movieId) {
  let favorites = getFavorites();
  favorites = favorites.filter(fav => fav.id !== movieId);
  localStorage.setItem('horrorverse_favorites', JSON.stringify(favorites));
  return { success: true, message: 'Removed from favorites' };
}

function isInFavorites(movieId) {
  const favorites = getFavorites();
  return favorites.some(fav => fav.id === movieId);
}

// ============================================
// WATCHLIST MANAGEMENT
// ============================================

function getWatchlist() {
  const stored = localStorage.getItem('horrorverse_watchlist');
  return stored ? JSON.parse(stored) : [];
}

function addToWatchlist(movie, status = 'to-watch') {
  const watchlist = getWatchlist();
  
  // Check if already exists
  const exists = watchlist.some(item => item.id === movie.id);
  
  if (!exists) {
    const watchlistItem = {
      ...movie,
      status: status, // 'to-watch', 'watching', 'completed'
      addedDate: new Date().toISOString()
    };
    
    watchlist.push(watchlistItem);
    localStorage.setItem('horrorverse_watchlist', JSON.stringify(watchlist));
    return { success: true, message: 'Added to watchlist' };
  }
  
  return { success: false, message: 'Already in watchlist' };
}

function removeFromWatchlist(movieId) {
  let watchlist = getWatchlist();
  watchlist = watchlist.filter(item => item.id !== movieId);
  localStorage.setItem('horrorverse_watchlist', JSON.stringify(watchlist));
  return { success: true, message: 'Removed from watchlist' };
}

function isInWatchlist(movieId) {
  const watchlist = getWatchlist();
  return watchlist.some(item => item.id === movieId);
}

function updateWatchlistStatus(movieId, newStatus) {
  const watchlist = getWatchlist();
  const item = watchlist.find(item => item.id === movieId);
  
  if (item) {
    item.status = newStatus;
    localStorage.setItem('horrorverse_watchlist', JSON.stringify(watchlist));
    return { success: true, message: 'Status updated' };
  }
  
  return { success: false, message: 'Movie not found in watchlist' };
}

// ============================================
// ATTACH TO GLOBAL OBJECT
// ============================================

window.HorrorVerse.getFavorites = getFavorites;
window.HorrorVerse.addToFavorites = addToFavorites;
window.HorrorVerse.removeFromFavorites = removeFromFavorites;
window.HorrorVerse.isInFavorites = isInFavorites;

window.HorrorVerse.getWatchlist = getWatchlist;
window.HorrorVerse.addToWatchlist = addToWatchlist;
window.HorrorVerse.removeFromWatchlist = removeFromWatchlist;
window.HorrorVerse.isInWatchlist = isInWatchlist;
window.HorrorVerse.updateWatchlistStatus = updateWatchlistStatus;

// ============================================
// UTILITY FUNCTIONS
// ============================================

window.HorrorVerse.showNotification = function(message, color = '#dc143c') {
  const notification = document.createElement('div');
  notification.textContent = message;
  notification.style.cssText = `
    position: fixed;
    top: 100px;
    right: 30px;
    background: ${color};
    color: white;
    padding: 15px 25px;
    border-radius: 10px;
    box-shadow: 0 5px 20px rgba(0,0,0,0.5);
    z-index: 10000;
    font-weight: bold;
    animation: slideIn 0.3s;
    border: 2px solid rgba(255,255,255,0.3);
  `;
  document.body.appendChild(notification);
  setTimeout(() => {
    notification.style.opacity = '0';
    notification.style.transition = 'opacity 0.3s';
    setTimeout(() => notification.remove(), 300);
  }, 2500);
};

console.log('%c🎃 HorrorVerse Shared Functions Loaded! 🎃', 'font-size: 16px; color: #dc143c; font-weight: bold;');