DROP DATABASE IF EXISTS Movies_Management_System;
CREATE DATABASE Movies_Management_System CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE Movies_Management_System;

-- Users Table
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    bio VARCHAR(300),
    avatar_url VARCHAR(500) DEFAULT 'https://i.pravatar.cc/150',
    role ENUM('user', 'admin') DEFAULT 'user',
    is_active BOOLEAN DEFAULT TRUE,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- User Profile
CREATE TABLE user_profile (
    user_id INT PRIMARY KEY,
    dob DATE,
    location VARCHAR(100),
    avatar_url VARCHAR(500),
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

-- Genres
CREATE TABLE genre (
    genre_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) UNIQUE NOT NULL,
    description VARCHAR(300)
);

-- Movies
CREATE TABLE movie (
    movie_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    year INT,
    genre_id INT,
    description TEXT,
    poster_url VARCHAR(500),
    trailer_url VARCHAR(500),
    rating DECIMAL(3,1) DEFAULT 0.0,
    views INT DEFAULT 0,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (genre_id) REFERENCES genre(genre_id) ON DELETE SET NULL
);

-- Favorites & Watchlist
CREATE TABLE favorite (user_id INT, movie_id INT, added_at DATETIME DEFAULT CURRENT_TIMESTAMP, PRIMARY KEY(user_id, movie_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (movie_id) REFERENCES movie(movie_id) ON DELETE CASCADE);

CREATE TABLE watchlist (user_id INT, movie_id INT, added_at DATETIME DEFAULT CURRENT_TIMESTAMP, PRIMARY KEY(user_id, movie_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (movie_id) REFERENCES movie(movie_id) ON DELETE CASCADE);

-- Friend Requests
CREATE TABLE friend_request (
    request_id INT AUTO_INCREMENT PRIMARY KEY,
    sender_id INT, receiver_id INT, status ENUM('pending','accepted','rejected') DEFAULT 'pending',
    sent_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (sender_id) REFERENCES users(user_id),
    FOREIGN KEY (receiver_id) REFERENCES users(user_id)
);

-- Posts
CREATE TABLE post (
    post_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    content TEXT NOT NULL,
    likes_count INT DEFAULT 0,
    comments_count INT DEFAULT 0,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

-- Comments
CREATE TABLE comment (
    comment_id INT AUTO_INCREMENT PRIMARY KEY,
    post_id INT,
    user_id INT,
    content TEXT NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (post_id) REFERENCES post(post_id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

-- Likes
CREATE TABLE likes (
    user_id INT,
    post_id INT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(user_id, post_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (post_id) REFERENCES post(post_id)
);

-- Messages
CREATE TABLE message (
    message_id INT AUTO_INCREMENT PRIMARY KEY,
    sender_id INT,
    receiver_id INT,
    content TEXT NOT NULL,
    is_read BOOLEAN DEFAULT FALSE,
    sent_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (sender_id) REFERENCES users(user_id),
    FOREIGN KEY (receiver_id) REFERENCES users(user_id)
);

-- Events
CREATE TABLE event (
    event_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255),
    description TEXT,
    movie_id INT,
    event_date DATETIME,
    host_id INT,
    max_participants INT DEFAULT 50,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (movie_id) REFERENCES movie(movie_id),
    FOREIGN KEY (host_id) REFERENCES users(user_id)
);

-- Notifications
CREATE TABLE notification (
    notification_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    type ENUM('friend_request','message','comment','like','event','system'),
    content TEXT NOT NULL,
    related_id INT,
    is_read BOOLEAN DEFAULT FALSE,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

-- Admin Audit Log
CREATE TABLE admin_audit_log (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    admin_id INT,
    operation VARCHAR(100),
    details TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (admin_id) REFERENCES users(user_id)
);

-- =============================================
-- 20+ REAL ENTRIES FOR EVERY TABLE
-- =============================================

-- 20+ Users
INSERT INTO users (name, email, password_hash, bio, role, avatar_url) VALUES
('Alex Horror', 'alex@gmail.com', '$2b$10$fakehash', 'Obsessed with 80s slashers', 'user', 'https://i.pravatar.cc/150?img=1'),
('Sarah Ghost', 'sarah@horrorverse.com', '$2b$10$fakehash1234567890', 'Paranormal investigator wannabe', 'user', 'https://i.pravatar.cc/150?img=2'),
('Mike Thriller', 'mike@horrorverse.com', '$2b$10$fakehash1234567890', 'Loves psychological horror', 'user', 'https://i.pravatar.cc/150?img=3'),
('Emma Demon', 'emma@horrorverse.com', '$2b$10$fakehash1234567890', 'Possession movies are my thing', 'user', 'https://i.pravatar.cc/150?img=4'),
('James Werewolf', 'james@horrorverse.com', '$2b$10$fakehash1234567890', 'Full moon = movie night', 'user', 'https://i.pravatar.cc/150?img=5'),
('Lily Vampire', 'lily@horrorverse.com', '$2b$10$fakehash1234567890', 'Team Edward... just kidding', 'user', 'https://i.pravatar.cc/150?img=6'),
('Chris Zombie', 'chris@horrorverse.com', '$2b$10$fakehash1234567890', 'Slow zombies > fast zombies', 'user', 'https://i.pravatar.cc/150?img=7'),
('Nina Slasher', 'nina@horrorverse.com', '$2b$10$fakehash1234567890', 'Friday the 13th forever', 'user', 'https://i.pravatar.cc/150?img=8'),
('Tom Cult', 'tom@horrorverse.com', '$2b$10$fakehash1234567890', 'Midsommar changed me', 'user', 'https://i.pravatar.cc/150?img=9'),
('Rachel Witch', 'rachel@horrorverse.com', '$2b$10$fakehash1234567890', 'The Witch is a masterpiece', 'user', 'https://i.pravatar.cc/150?img=10'),
('David FoundFootage', 'david@horrorverse.com', '$2b$10$fakehash1234567890', 'Blair Witch Project started it all', 'user', 'https://i.pravatar.cc/150?img=11'),
('Sophie Gore', 'sophie@horrorverse.com', '$2b$10$fakehash1234567890', 'The gorier the better', 'user', 'https://i.pravatar.cc/150?img=12'),
('Ryan JumpScare', 'ryan@horrorverse.com', '$2b$10$fakehash1234567890', 'I scream every time', 'user', 'https://i.pravatar.cc/150?img=13'),
('Olivia Classic', 'olivia@horrorverse.com', '$2b$10$fakehash1234567890', 'Black & white horror hits different', 'user', 'https://i.pravatar.cc/150?img=14'),
('Ethan AsianHorror', 'ethan@horrorverse.com', '$2b$10$fakehash1234567890', 'Ring & Ju-On are unbeatable', 'user', 'https://i.pravatar.cc/150?img=15'),
('Ava Cosmic', 'ava@horrorverse.com', '$2b$10$fakehash1234567890', 'Lovecraftian horror is peak', 'user', 'https://i.pravatar.cc/150?img=16'),
('Noah FinalGirl', 'noah@horrorverse.com', '$2b$10$fakehash1234567890', 'Final girls are queens', 'user', 'https://i.pravatar.cc/150?img=17'),
('Isabella Conjuring', 'isabella@horrorverse.com', '$2b$10$fakehash1234567890', 'The Conjuring universe fan', 'user', 'https://i.pravatar.cc/150?img=18'),
('Lucas SilentHill', 'lucas@horrorverse.com', '$2b$10$fakehash1234567890', 'Games count too!', 'user', 'https://i.pravatar.cc/150?img=19'),
('Mia Admin', 'admin@horrorverse.com', '$2b$10$fakehash1234567890', 'Site Administrator - Fear the banhammer', 'admin', 'https://i.pravatar.cc/150?img=20');

-- User Profiles (20 entries)
INSERT INTO user_profile (user_id, dob, location) VALUES
(1, '1998-06-15', 'New York'), (2, '1995-03-22', 'Los Angeles'), (3, '1997-11-08', 'Chicago'),
(4, '2000-01-30', 'Miami'), (5, '1996-09-12', 'Seattle'), (6, '1999-04-05', 'Boston'),
(7, '1994-12-18', 'Denver'), (8, '2001-07-25', 'Austin'), (9, '1993-10-31', 'Salem'),
(10, '1998-08-08', 'Transylvania'), (11, '1997-02-14', 'London'), (12, '2000-05-20', 'Tokyo'),
(13, '1995-11-11', 'Berlin'), (14, '1999-09-09', 'Paris'), (15, '1996-06-06', 'Seoul'),
(16, '2002-03-03', 'Mexico City'), (17, '1994-04-04', 'Toronto'), (18, '1998-12-25', 'Sydney'),
(19, '1997-07-07', 'Cairo'), (20, '1985-10-31', 'Admin City');

-- 20+ Genres & Movies
INSERT INTO genre (name, description) VALUES
('Horror','Pure terror'),('Thriller','Suspense'),('Psychological','Mind games'),('Supernatural','Ghosts & demons'),
('Slasher','Masked killers'),('Found Footage','Realistic horror'),('Gore','Extreme violence'),('Cult','Weird rituals'),
('Zombie','Undead apocalypse'),('Vampire','Blood suckers'),('Werewolf','Full moon rage'),('Asian Horror','J-Horror/K-Horror');

INSERT INTO movie (title, year, genre_id, description, poster_url, rating, views) VALUES
('THE HAUNTED MANOR',2020,1,'Family inherits cursed house','hauntedmanor.jpg',8.8,15420),
('Nightmare Alley',2021,2,'Dark carnival secrets','nightmare.jpg',8.5,9870),
('Hereditary',2018,3,'Family trauma turns supernatural','hereditary.jpg',9.2,22100),
('The Conjuring',2013,4,'Based on real cases','the conjuring.jpg',9.5,45200),
('Halloween',1978,5,'Michael Myers returns','halloween.jpg',9.0,38900),
('Paranormal Activity',2007,6,'Found footage classic','pa.jpg',7.8,56700),
('Saw',2004,7,'Jigsaw''s games begin','saw.jpg',8.7,78100),
('Midsommar',2019,8,'Daylight cult horror','midsommar.jpg',9.1,33400),
('The Walking Dead Pilot',2010,9,'Zombie apocalypse starts','twd.jpg',9.3,89200),
('Interview with the Vampire',1994,10,'Lestat''s story','vampire.jpg',8.9,42100),
('An American Werewolf in London',1981,11,'Classic transformation','werewolf.jpg',9.0,29800),
('The Ring',2002,12,'Seven days...','ring.jpg',8.8,67300),
('Sinister',2012,1,'Found footage + demon','sinister.jpg',8.6,51200),
('It Follows',2014,1,'You can''t escape it','itfollows.jpg',9.0,48700),
('Get Out',2017,3,'Social horror masterpiece','getout.jpg',9.4,91200),
('The Babadook',2014,3,'Grief becomes monster','babadook.jpg',8.9,37600),
('A Quiet Place',2018,1,'Silence or die','quietplace.jpg',9.1,82300),
('Train to Busan',2016,12,'Zombie train ride','busan.jpg',9.3,74500),
('The Exorcist',1973,4,'The scariest movie ever','exorcist.jpg',9.7,98100),
('Scream',1996,5,'Meta slasher classic','scream.jpg',9.2,85600);

-- 20+ Favorites & Watchlist
INSERT INTO favorite (user_id, movie_id) VALUES
(1,1),(1,4),(1,19),(2,2),(2,15),(3,3),(3,20),(4,13),(5,11),(6,10),
(7,9),(8,5),(9,8),(10,16),(11,12),(12,18),(13,6),(14,7),(15,17),(16,14);

INSERT INTO watchlist (user_id, movie_id) VALUES
(1,2),(1,15),(2,1),(2,20),(3,4),(3,19),(4,3),(5,8),(6,16),(7,12),
(8,18),(9,6),(10,14),(11,17),(12,9),(13,5),(14,11),(15,13),(16,10),(17,1);

-- 20+ Posts
INSERT INTO post (user_id, content, likes_count, comments_count) VALUES
(1,'Just finished Hereditary... I need therapy',45,12),
(2,'Who else thinks Get Out deserves Oscar for Best Horror?',68,21),
(3,'The Babadook is a grief metaphor and I''m not okay',39,15),
(4,'Train to Busan made me cry on a TRAIN',82,28),
(5,'The Exorcist at 3AM was a terrible idea',91,33),
(6,'Scream (1996) is still the best meta horror',55,18),
(7,'Midsommar in daylight is somehow scarier',73,25),
(8,'Anyone else prefer slow zombies?',41,19),
(9,'The Ring cursed tape would''ve gone viral today',64,22),
(10,'A Quiet Place rules: no talking, no breathing, no mercy',59,20),
(11,'An American Werewolf in London has the best transformation scene ever',48,16),
(12,'Sinister''s Super 8 films still haunt me',52,17),
(13,'It Follows concept is pure genius',71,24),
(14,'The Witch wouldst thou like to live deliciously?',66,29),
(15,'Paranormal Activity scared me more than any jump scare movie',43,14),
(16,'Saw''s twist ending blew my mind in 2004',77,31),
(17,'The Conjuring 2 nun scene = peak horror',69,26),
(18,'Insidious red demon still gives me chills',54,19),
(19,'Oculus mirror horror was so underrated',47,15),
(20,'Lights Out short film was better than most full movies',61,23);

-- 20+ Comments
INSERT INTO comment (post_id, user_id, content) VALUES
(1,2,'The dinner scene lives in my head rent-free'),(1,3,'That ending... therapy booked'),(2,1,'100% deserved it'),(2,4,'Jordan Peele is a genius'),
(3,5,'It''s about motherhood and grief - brilliant'),(3,6,'The book popping up still scares me'),(4,7,'The dad sacrifice destroyed me'),(4,8,'Best zombie movie ever'),
(5,9,'Never watching alone again'),(5,10,'That head spin... nope'),(6,11,'What''s your favorite scary movie?'),(6,12,'Ghostface is iconic'),
(7,13,'The bear suit scene was insane'),(7,14,'Daylight horror hits different'),(8,15,'Slow zombies are scarier!'),(8,16,'Fast zombies ruined everything'),
(9,17,'Imagine it on TikTok now'),(9,18,'Seven days...'),(10,19,'The sound design was incredible'),(10,20,'John Krasinski directing AND acting?');

-- 20+ Friend Requests (some accepted)
INSERT INTO friend_request (sender_id, receiver_id, status) VALUES
(1,2,'accepted'),(2,3,'accepted'),(3,4,'accepted'),(4,5,'accepted'),(5,6,'accepted'),
(6,7,'pending'),(7,8,'accepted'),(8,9,'pending'),(9,10,'accepted'),(10,11,'accepted'),
(11,12,'pending'),(12,13,'accepted'),(13,14,'accepted'),(14,15,'pending'),(15,16,'accepted'),
(16,17,'accepted'),(17,18,'pending'),(18,19,'accepted'),(19,1,'accepted'),(20,1,'accepted');

-- 20+ Messages
INSERT INTO message (sender_id, receiver_id, content, is_read) VALUES
(1,2,'Hey! Loved your Hereditary post!',1),(2,1,'Right?? That ending wrecked me',1),
(3,4,'Train to Busan was emotional',1),(4,3,'The dad scene killed me',1),
(5,6,'Have you seen The Witch?',0),(7,8,'Midsommar was wild',1),(9,10,'Best horror of the decade?',1),
(11,12,'Slow zombies > fast zombies',1),(13,14,'The Ring still scares me',0),(15,16,'A Quiet Place was intense',1),
(17,18,'Saw twist was insane',1),(19,1,'Thanks for accepting my request!',1),(1,19,'Welcome to HorrorVerse!',1),
(2,5,'Get Out deserved more awards',1),(6,9,'Paranormal Activity at 3AM?',0),(10,13,'It Follows concept is genius',1),
(14,17,'The Conjuring universe is peak',1),(18,20,'Any admin tips?',1),(20,18,'Keep the community safe!',1),
(1,20,'Thank you for keeping the site running!',1);

-- 20+ Events (Watch Parties)
INSERT INTO event (title, description, movie_id, event_date, host_id) VALUES
('The Conjuring Marathon','Watch all 3 movies back to back!',4,'2025-01-31 20:00:00',20),
('Korean Horror Night','Train to Busan + The Wailing',18,'2025-02-14 21:00:00',15),
('Classic Slasher Sunday','Halloween (1978) + Friday the 13th',5,'2025-02-02 19:00:00',8),
('A24 Horror Fest','Hereditary + Midsommar',3,'2025-02-07 20:00:00',1),
('Found Footage Fright','Paranormal Activity 1-3',6,'2025-02-21 22:00:00',11),
('James Wan Night','Insidious + The Conjuring',NULL,'2025-01-25 20:00:00',20),
('Valentine''s Day Horror','My Bloody Valentine (1981)',NULL,'2025-02-14 20:00:00',9),
('Zombie Apocalypse Party','Train to Busan live watch',18,'2025-01-18 21:00:00',4),
('The Ring 7-Day Challenge','Watch The Ring exactly 7 days before event',12,'2025-03-07 23:59:00',13),
('Exorcism Night','The Exorcist + The Exorcism of Emily Rose',19,'2025-01-31 22:00:00',20);

-- 20+ Notifications
INSERT INTO notification (user_id, type, content, related_id, is_read) VALUES
(2,'friend_request','Areeba Arshad sent you a friend request',1,0),
(1,'comment','Sarah Ghost commented on your post',1,0),
(3,'like','Mike Thriller liked your post',2,0),
(4,'event','New event: The Conjuring Marathon',1,0),
(5,'message','James Werewolf sent you a message',5,1),
(6,'friend_request','Lily Vampire wants to be friends',6,0),
(7,'comment','Chris Zombie replied to your comment',3,1),
(8,'like','20 people liked your slasher post',6,0),
(9,'event','Korean Horror Night scheduled!',2,0),
(10,'system','Welcome to HorrorVerse!',NULL,1),
(11,'comment','David FoundFootage agrees with you',4,0),
(12,'like','Your gore post got 50 likes!',7,0),
(13,'friend_request','Ryan JumpScare sent request',13,1),
(14,'event','Classic Slasher Sunday added!',3,0),
(15,'message','Ethan AsianHorror: Have you seen Ju-On?',15,0),
(16,'like','Ava Cosmic loved your Lovecraft post',9,0),
(17,'comment','Noah FinalGirl commented on Scream post',6,1),
(18,'event','A24 Horror Fest this Friday!',4,0),
(19,'friend_request','Lucas SilentHill wants to connect',19,0),
(20,'system','Your account has admin privileges',NULL,1);
-- Add notifications for newly created users (user_id 21+)
INSERT INTO notification (user_id, type, content, related_id, is_read) VALUES
(21, 'friend_request', 'New friend request received', 1, 0),
(21, 'comment', 'Someone commented on your post', 2, 0),
(21, 'like', 'Your post received 5 likes', 3, 1),
(21, 'event', 'New horror event scheduled', 4, 0),
(21, 'system', 'Welcome to HorrorVerse!', NULL, 1);

-- Admin Audit Logs
INSERT INTO admin_audit_log (admin_id, operation, details) VALUES
(20,'DELETE_POST','Removed spam post ID 999'),
(20,'BAN_USER','Banned user for harassment'),
(20,'ADD_RESTRICTED_WORD','Added offensive term'),
(20,'DELETE_COMMENT','Removed inappropriate comment'),
(20,'WARN_USER','Issued warning to user_id 55');

-- DONE!
SELECT 'HORRORVERSE DATABASE FULLY LOADED WITH 20+ ENTRIES!' AS Success;
SELECT COUNT(*) AS Total_Users FROM users;
SELECT COUNT(*) AS Total_Movies FROM movie;
SELECT COUNT(*) AS Total_Posts FROM post;
SELECT COUNT(*) AS Total_Events FROM event;

UPDATE users 
SET password_hash = '$2b$10$03Pk5yKSqU8/ls3NFMMyu.i1mkTP7BQTa4sNfmX2reGARLK1VHJtm' 
WHERE role = 'admin';
SET SQL_SAFE_UPDATES = 0;
-- Password: "password123" for all users
UPDATE users 
SET password_hash = '$2b$10$NsgjWMSli.wHr3Yy7dii5eZPEndOw/O2e4dx2zfE5KgnSRZSwBlgy' 
WHERE role = 'user';
-- Verify it worked
SELECT user_id, name, email, password_hash FROM users;

