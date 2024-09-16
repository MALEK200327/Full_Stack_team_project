BEGIN TRANSACTION;

CREATE TABLE IF NOT EXISTS "courses" (
	"courseID"	INTEGER,
	"course_title"	TEXT,
	"description"	TEXT,
	"privacy"	TEXT,
	PRIMARY KEY("courseID")
);
CREATE TABLE IF NOT EXISTS "users_courses" (
	"userID"	INTEGER,
	"courseID"	INTEGER,
	"username"	TEXT,
	"course_title"	TEXT,
	PRIMARY KEY("userID","courseID")
);
CREATE TABLE IF NOT EXISTS "user_staff" (
	"userID"	INTEGER,
	"role"	TEXT,
	PRIMARY KEY("userID","role"),
	FOREIGN KEY (userID)REFERENCES users(userID)
);
CREATE TABLE IF NOT EXISTS "users" (
	"userID"	INTEGER,
	"username"	TEXT,
	"first_name"	TEXT,
	"surname"	TEXT,
	"email"	TEXT,
	"password"	TEXT,
	PRIMARY KEY("userID")
);

SELECT u.* FROM users u JOIN user_staff us ON u.userID = us.userID WHERE us.role = 'admin';
SELECT u.* FROM users u JOIN user_staff us ON u.userID = us.userID WHERE us.role = 'learner';
SELECT u.* FROM users u JOIN user_staff us ON u.userID = us.userID WHERE us.role = 'moderator';

COMMIT;


