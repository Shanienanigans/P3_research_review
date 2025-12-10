-- ============================================================================
-- USE DATABASE
-- ============================================================================
USE open_review_platform;



-- ============================================================================
-- USER QUERIES
-- ============================================================================

-- PURPOSE: Authenticate a user attempting to log in.
-- USED AT: http://localhost:8080/login
SELECT userId,
       username,
       password,
       firstName,
       lastName,
       institution,
       role
FROM user
WHERE username = ?;


-- PURPOSE: Register a new user into the system.
-- USED AT: http://localhost:8080/register
INSERT INTO user (username, password, firstName, lastName, institution, role)
VALUES (?, ?, ?, ?, ?, ?);


-- PURPOSE: Fetch user profile information by ID.
-- USED AT: GET /profile
-- USED AT: GET /profile/{userId}
-- USED AT: GET /users/{userId}
SELECT userId,
       username,
       firstName,
       lastName,
       institution,
       role
FROM user
WHERE userId = ?;


-- PURPOSE: List all users in the system (admin list or People page).
-- USED AT: http://localhost:8080/users
SELECT userId,
       username,
       firstName,
       lastName,
       institution,
       role
FROM user
ORDER BY lastName ASC, firstName ASC;


-- PURPOSE: Fetch all researchers (role='author') for Authors page.
-- USED AT: http://localhost:8080/authors
SELECT userId,
       username,
       firstName,
       lastName,
       institution,
       role
FROM user
WHERE role = ?
ORDER BY lastName ASC, firstName ASC;


-- PURPOSE: Search for researchers (role='author') by name, email, or institution.
-- USED AT: http://localhost:8080/authors?q=...
SELECT userId,
       username,
       firstName,
       lastName,
       institution,
       role
FROM user
WHERE role = 'author'
  AND (
        LOWER(firstName) LIKE ?
        OR LOWER(lastName) LIKE ?
        OR LOWER(CONCAT(firstName, ' ', lastName)) LIKE ?
        OR LOWER(username) LIKE ?
        OR LOWER(institution) LIKE ?
      )
ORDER BY lastName ASC, firstName ASC;



-- ============================================================================
-- FOLLOW / UNFOLLOW QUERIES
-- ============================================================================

-- PURPOSE: Check whether a user is following another user.
-- USED AT: http://localhost:8080/authors
SELECT COUNT(*) FROM follow WHERE followerId = ? AND followeeId = ?;


-- PURPOSE: Create a new follow relationship.
-- USED AT: http://localhost:8080/authors/{userId}/follow
INSERT IGNORE INTO follow (followerId, followeeId)
VALUES (?, ?);


-- PURPOSE: Remove a follow relationship.
-- USED AT: http://localhost:8080/authors/{userId}/follow
DELETE FROM follow WHERE followerId = ? AND followeeId = ?;


-- PURPOSE: Get list of userIds that the current user follows.
-- USED AT: http://localhost:8080/authors
SELECT followeeId FROM follow WHERE followerId = ?;



-- ============================================================================
-- PAPER QUERIES
-- ============================================================================

-- PURPOSE: Insert a newly uploaded paper.
-- USED AT: http://localhost:8080/papers/upload
INSERT INTO paper (title, abstract, authors, filePath, uploaderId)
VALUES (?, ?, ?, ?, ?);


-- PURPOSE: Fetch a single paper with aggregated review info.
-- USED AT: http://localhost:8080/papers/{paperId}
-- USED AT: http://localhost:8080/papers/{paperId}/edit
-- USED AT: http://localhost:8080/discussion/{paperId}
SELECT p.paperId,
       p.title,
       p.authors,
       p.abstract AS abstractText,
       p.filePath,
       DATE_FORMAT(
            CONVERT_TZ(p.uploadedAt, '+00:00', '-04:00'),
            '%b %e, %Y %l:%i %p'
       ) AS uploadDate,
       p.uploaderId,
       COALESCE(AVG(r.overallScore), 0) AS avgScore,
       COUNT(r.reviewId)              AS reviewCount
FROM paper p
LEFT JOIN review r ON r.paperId = p.paperId
WHERE p.paperId = ?
GROUP BY p.paperId, p.title, abstractText, p.authors,
         p.filePath, p.uploadedAt, uploadDate, p.uploaderId;


-- PURPOSE: Fetch file path for streaming or downloading the PDF.
-- USED AT: http://localhost:8080/papers/{paperId}/download
SELECT filePath FROM paper WHERE paperId = ?;


-- PURPOSE: Fetch all papers with aggregated review stats (homepage, all papers).
-- USED AT: http://localhost:8080/papers
SELECT p.paperId,
    p.title,
    p.authors,
    p.abstract AS abstractText,
    DATE_FORMAT(
            CONVERT_TZ(p.uploadedAt, '+00:00', '-04:00'),
            '%b %e, %Y %l:%i %p'
    ) AS uploadDate,
    p.uploaderId,
    COALESCE(AVG(r.overallScore), 0) AS avgScore,
    COUNT(r.reviewId)              AS reviewCount
FROM paper p
LEFT JOIN review r ON r.paperId = p.paperId
GROUP BY p.paperId, p.title, abstractText, p.authors,
        p.uploadedAt, uploadDate, p.uploaderId
ORDER BY p.uploadedAt DESC;


-- PURPOSE: Search for papers by title, authors, or abstract.
-- USED AT: http://localhost:8080/search
SELECT 
    p.paperId,
    p.title,
    p.authors,
    p.abstract AS abstractText,
    DATE_FORMAT(
        CONVERT_TZ(p.uploadedAt, '+00:00', '-04:00'),
        '%b %e, %Y %l:%i %p'
    ) AS uploadDate,

    u.userId,
    u.firstName,
    u.lastName,
    u.role,
    u.institution,
    u.profileImagePath,

    COALESCE(AVG(r.overallScore), 0) AS avgScore,
    COUNT(r.reviewId) AS reviewCount

FROM paper p
JOIN user u ON p.uploaderId = u.userId
LEFT JOIN review r ON r.paperId = p.paperId

WHERE 
    LOWER(p.title) LIKE LOWER(?)
    OR LOWER(p.authors) LIKE LOWER(?)
    OR LOWER(p.abstract) LIKE LOWER(?)

GROUP BY 
    p.paperId, p.title, abstractText, uploadDate,
    u.userId, u.firstName, u.lastName,
    u.role, u.institution, u.profileImagePath

ORDER BY p.uploadedAt DESC;


-- PURPOSE: Fetch papers uploaded by a specific user.
-- USED AT: http://localhost:8080/profile/{userId}
-- USED AT: http://localhost:8080/users/{userId}
SELECT p.paperId,
       p.title,
       p.authors,
       p.abstract AS abstractText,
       p.filePath,
       DATE_FORMAT(
            CONVERT_TZ(p.uploadedAt, '+00:00', '-04:00'),
            '%b %e, %Y %l:%i %p'
       ) AS uploadDate,
       p.uploaderId,
       COALESCE(AVG(r.overallScore), 0) AS avgScore,
       COUNT(r.reviewId)              AS reviewCount
FROM paper p
LEFT JOIN review r ON r.paperId = p.paperId
WHERE p.uploaderId = ?
GROUP BY p.paperId, p.title, abstractText, p.authors,
         p.filePath, p.uploadedAt, uploadDate, p.uploaderId
ORDER BY p.uploadedAt DESC;


-- PURPOSE: Update paper metadata (title, abstract, authors).
-- USED AT: http://localhost:8080/papers/{paperId}/edit
UPDATE paper
SET title = ?, abstract = ?, authors = ?
WHERE paperId = ?;


-- PURPOSE: Update paper metadata AND file path when a new PDF is uploaded.
-- USED AT: http://localhost:8080/papers/{paperId}/edit
UPDATE paper
SET title = ?, abstract = ?, authors = ?, filePath = ?
WHERE paperId = ?;



-- ============================================================================
-- COMMENT / DISCUSSION QUERIES
-- ============================================================================

-- PURPOSE: Fetch threaded comments for a paper's discussion page.
-- USED AT:http://localhost:8080/discussion/{paperId}
SELECT c.commentId,
    c.paperId,
    c.userId,
    c.content,
    DATE_FORMAT(
            CONVERT_TZ(c.createdAt, '+00:00', '-04:00'),
            '%b %e, %Y %l:%i %p'
    ) AS createdAt,
    c.parentCommentId
FROM comment c
WHERE c.paperId = ?
ORDER BY c.createdAt ASC;


-- PURPOSE: Insert a new comment or threaded reply.
-- USED AT: http://localhost:8080/discussion/{paperId}/add
INSERT INTO comment (paperId, userId, content, parentCommentId)
VALUES (?, ?, ?, ?);



-- ============================================================================
-- REVIEW QUERIES
-- ============================================================================

-- PURPOSE: Submit a new review (overall fields only).
-- USED AT: http://localhost:8080/reviews/add/{paperId}
INSERT INTO review (paperId, reviewerId, overallScore, confidence, verdict, feedback)
VALUES (?, ?, ?, ?, ?, ?);


-- PURPOSE: Fetch all reviews for a specific paper.
-- USED AT: http://localhost:8080/reviews/{paperId}
-- USED AT: http://localhost:8080/papers/{paperId}
SELECT r.reviewId,
       r.paperId,
       r.reviewerId,
       r.overallScore,
       r.confidence,
       r.verdict,
       r.feedback,
       DATE_FORMAT(CONVERT_TZ(r.createdAt, '+00:00', '-04:00'),
                   '%b %e, %Y %l:%i %p') AS reviewDate
FROM review r
WHERE r.paperId = ?
ORDER BY r.createdAt DESC;


-- PURPOSE: Fetch criterion scores for a specific review.
-- USED AT: http://localhost:8080/reviews/{paperId}
-- USED AT: http://localhost:8080/papers/{paperId}
SELECT reviewId, criterionId, score
FROM review_criterion_score
WHERE reviewId = ?;


-- PURPOSE: Fetch all reviews submitted by a particular user.
-- USED AT: http://localhost:8080/profile/{userId}
SELECT r.reviewId,
       r.paperId,
       r.reviewerId,
       r.overallScore,
       r.confidence,
       r.verdict,
       r.feedback,
       DATE_FORMAT(CONVERT_TZ(r.createdAt, '+00:00', '-04:00'),
                   '%b %e, %Y %l:%i %p') AS reviewDate
FROM review r
WHERE r.reviewerId = ?
ORDER BY r.createdAt DESC;


-- PURPOSE: Fetch paper title for showing review references on profile pages.
-- USED AT: http://localhost:8080/profile/{userId}
SELECT title FROM paper WHERE paperId = ?;



-- ============================================================================
-- CRITERION (REVIEW METRICS) QUERIES
-- ============================================================================

-- PURPOSE: Insert a review criterion (admin only).
-- USED AT: http://localhost:8080/criteria/add
INSERT INTO criterion (name, description)
VALUES (?, ?);


-- PURPOSE: Fetch all review criteria for admin management.
-- USED AT: http://localhost:8080/criteria
SELECT * FROM criterion ORDER BY name ASC;


-- PURPOSE: Delete a review criterion.
-- USED AT: http://localhost:8080/criteria/delete
DELETE FROM criterion WHERE criterionId = ?;
