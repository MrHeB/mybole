CREATE DATABASE IF NOT EXISTS mybole CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
-- 创建用户表
CREATE TABLE users (
                       id INT AUTO_INCREMENT PRIMARY KEY,
                       username VARCHAR(50) NOT NULL UNIQUE,
                       email VARCHAR(100) NOT NULL UNIQUE,
                       password_hash VARCHAR(255) NOT NULL,
                       full_name VARCHAR(100),
                       bio TEXT,
                       avatar_url VARCHAR(255),
                       role ENUM('admin', 'editor', 'viewer') DEFAULT 'viewer',
                       is_active BOOLEAN DEFAULT TRUE,
                       created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                       updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- 创建文章分类表
CREATE TABLE categories (
                            id INT AUTO_INCREMENT PRIMARY KEY,
                            name VARCHAR(100) NOT NULL UNIQUE,
                            slug VARCHAR(100) NOT NULL UNIQUE,
                            description TEXT,
                            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                            updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- 创建文章表
CREATE TABLE articles (
                          id INT AUTO_INCREMENT PRIMARY KEY,
                          title VARCHAR(255) NOT NULL,
                          slug VARCHAR(255) NOT NULL UNIQUE,
                          content TEXT NOT NULL,
                          excerpt TEXT,
                          author_id INT NOT NULL,
                          category_id INT,
                          featured_image_url VARCHAR(255),
                          status ENUM('draft', 'published', 'archived') DEFAULT 'draft',
                          view_count INT DEFAULT 0,
                          created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                          updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                          published_at TIMESTAMP NULL,
                          FOREIGN KEY (author_id) REFERENCES users(id) ON DELETE CASCADE,
                          FOREIGN KEY (category_id) REFERENCES categories(id) ON DELETE SET NULL
);

-- 创建标签表
CREATE TABLE tags (
                      id INT AUTO_INCREMENT PRIMARY KEY,
                      name VARCHAR(50) NOT NULL UNIQUE,
                      slug VARCHAR(50) NOT NULL UNIQUE,
                      created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 文章与标签的关联表（多对多）
CREATE TABLE article_tags (
                              article_id INT NOT NULL,
                              tag_id INT NOT NULL,
                              PRIMARY KEY (article_id, tag_id),
                              FOREIGN KEY (article_id) REFERENCES articles(id) ON DELETE CASCADE,
                              FOREIGN KEY (tag_id) REFERENCES tags(id) ON DELETE CASCADE
);

-- 创建评论表
CREATE TABLE comments (
                          id INT AUTO_INCREMENT PRIMARY KEY,
                          article_id INT NOT NULL,
                          user_id INT,
                          content TEXT NOT NULL,
                          parent_id INT NULL,
                          is_approved BOOLEAN DEFAULT TRUE,
                          created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                          updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                          FOREIGN KEY (article_id) REFERENCES articles(id) ON DELETE CASCADE,
                          FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE SET NULL,
                          FOREIGN KEY (parent_id) REFERENCES comments(id) ON DELETE CASCADE
);

-- 创建用户会话表
CREATE TABLE user_sessions (
                               id INT AUTO_INCREMENT PRIMARY KEY,
                               user_id INT NOT NULL,
                               session_token VARCHAR(255) NOT NULL UNIQUE,
                               expires_at TIMESTAMP NOT NULL,
                               created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                               FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- 创建索引以提高查询性能
CREATE INDEX idx_articles_author ON articles(author_id);
CREATE INDEX idx_articles_category ON articles(category_id);
CREATE INDEX idx_articles_status ON articles(status);
CREATE INDEX idx_comments_article ON comments(article_id);
CREATE INDEX idx_comments_user ON comments(user_id);