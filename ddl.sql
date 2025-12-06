-- ======================================
-- Create Database
-- ======================================
CREATE DATABASE IF NOT EXISTS open_review_platform;
USE open_review_platform;

-- ======================================
-- USERS TABLE
-- ======================================
CREATE TABLE IF NOT EXISTS user (
    userId INT AUTO_INCREMENT,
    username VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    firstName VARCHAR(255) NOT NULL,
    lastName VARCHAR(255) NOT NULL,
    role ENUM('author','reviewer','admin') DEFAULT 'author',
    institution VARCHAR(255),
    profileImagePath VARCHAR(255) DEFAULT '/avatars/default.png',
    PRIMARY KEY (userId)
);

-- ======================================
-- PAPERS TABLE
-- ======================================
CREATE TABLE IF NOT EXISTS paper (
    paperId INT AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    abstract TEXT NOT NULL,
    authors VARCHAR(500) NOT NULL,
    uploaderId INT NOT NULL,
    filePath VARCHAR(500) NOT NULL,
    uploadedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (paperId),
    FOREIGN KEY (uploaderId) REFERENCES user(userId)
);

-- ======================================
-- COMMENTS TABLE (for public discussion)
-- ======================================
CREATE TABLE IF NOT EXISTS comment (
    commentId INT AUTO_INCREMENT,
    paperId INT NOT NULL,
    userId INT NOT NULL,
    content TEXT NOT NULL,
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (commentId),
    FOREIGN KEY (paperId) REFERENCES paper(paperId),
    FOREIGN KEY (userId) REFERENCES user(userId)
);

-- ======================================
-- REVIEWS TABLE (final simplified version)
-- ======================================
CREATE TABLE IF NOT EXISTS review (
    reviewId INT AUTO_INCREMENT,
    paperId INT NOT NULL,
    reviewerId INT NOT NULL,
    overallScore INT CHECK (overallScore BETWEEN 1 AND 10),
    confidence INT CHECK (confidence BETWEEN 1 AND 5),
    verdict ENUM('accept','weak_accept','borderline','weak_reject','reject') NOT NULL,
    feedback TEXT NOT NULL,   -- ⭐ FIXED: now matches your Spring model
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (reviewId),
    FOREIGN KEY (paperId) REFERENCES paper(paperId),
    FOREIGN KEY (reviewerId) REFERENCES user(userId)
);


-- ======================================
-- CRITERIA TABLE (admin defines)
-- ======================================
CREATE TABLE IF NOT EXISTS criterion (
    criterionId INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL UNIQUE,
    description TEXT
);

-- Add basic scoring criteria
INSERT IGNORE INTO criterion (name, description) VALUES
('Problem Statement', 'Clarity and importance of research question.'),
('Methodology', 'Soundness and rigor of the methods.'),
('Experiments', 'Quality and reproducibility of experiments.'),
('Results', 'Correctness and relevance of findings.'),
('Contribution', 'Novelty and impact of the research.');



-- ======================================
-- REVIEW CRITERION TABLE 
-- ======================================
CREATE TABLE review_criterion_score (
    id INT AUTO_INCREMENT PRIMARY KEY,
    reviewId INT NOT NULL,
    criterionId INT NOT NULL,
    score INT CHECK (score BETWEEN 1 AND 5),
    FOREIGN KEY (reviewId) REFERENCES review(reviewId) ON DELETE CASCADE,
    FOREIGN KEY (criterionId) REFERENCES criterion(criterionId)
);


-- ======================================
-- INDEXES FOR PERFORMANCE
-- ======================================

CREATE INDEX idx_paper_title ON paper(title);
CREATE INDEX idx_review_paperId ON review(paperId);
CREATE INDEX idx_user_username ON user(username);


-- ======================================
-- SEED BASIC USERS
-- ======================================
INSERT INTO user (username, password, firstName, lastName, role)
VALUES 
('admin', '$2a$10$H/jN2sxd6yBvDN3wyKvL2.KHiB/YxYoT0kZd1.cwEQZ5h4EJTlTIG', 'System', 'Admin', 'admin')
ON DUPLICATE KEY UPDATE username=username;

INSERT INTO user (username, password, firstName, lastName)
VALUES 
('alice', '$2a$10$H/jN2sxd6yBvDN3wyKvL2.KHiB/YxYoT0kZd1.cwEQZ5h4EJTlTIG', 'Alice', 'Anderson'),
('bob',   '$2a$10$H/jN2sxd6yBvDN3wyKvL2.KHiB/YxYoT0kZd1.cwEQZ5h4EJTlTIG', 'Bob', 'Baker'),
('cara',  '$2a$10$H/jN2sxd6yBvDN3wyKvL2.KHiB/YxYoT0kZd1.cwEQZ5h4EJTlTIG', 'Cara', 'Chen')
ON DUPLICATE KEY UPDATE username=username;
