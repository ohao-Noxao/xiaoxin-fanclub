-- 动态表
CREATE TABLE IF NOT EXISTS posts (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  author TEXT NOT NULL,
  avatar TEXT,
  body TEXT,
  media_src TEXT,
  media_type TEXT DEFAULT 'image',
  cover TEXT,
  video_link TEXT,
  likes INTEGER DEFAULT 0,
  comments_count INTEGER DEFAULT 0,
  time TEXT,
  timestamp INTEGER,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- 评论表
CREATE TABLE IF NOT EXISTS comments (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  post_id INTEGER NOT NULL,
  author TEXT NOT NULL,
  text TEXT NOT NULL,
  time TEXT,
  timestamp INTEGER,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (post_id) REFERENCES posts(id) ON DELETE CASCADE
);

-- 用户表
CREATE TABLE IF NOT EXISTS users (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  phone TEXT UNIQUE NOT NULL,
  name TEXT NOT NULL,
  password TEXT NOT NULL,
  avatar TEXT
);

-- 点赞记录表
CREATE TABLE IF NOT EXISTS likes (
  user_name TEXT NOT NULL,
  post_id INTEGER NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (user_name, post_id)
);

-- 收藏记录表
CREATE TABLE IF NOT EXISTS favorites (
  user_name TEXT NOT NULL,
  post_id INTEGER NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (user_name, post_id)
);

-- 史册事件表
CREATE TABLE IF NOT EXISTS events (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  date TEXT NOT NULL,
  title TEXT NOT NULL,
  description TEXT,
  author TEXT,
  image TEXT,
  time TEXT,
  timestamp INTEGER,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- 统计表
CREATE TABLE IF NOT EXISTS stats (
  key TEXT PRIMARY KEY,
  value INTEGER DEFAULT 0
);

-- 初始化统计
INSERT OR IGNORE INTO stats (key, value) VALUES ('total_visits', 0);
INSERT OR IGNORE INTO stats (key, value) VALUES ('today', 0);
INSERT OR IGNORE INTO stats (key, value) VALUES ('today_date', 0);
INSERT OR IGNORE INTO stats (key, value) VALUES ('member_count', 0);
