-- ============================================================================
-- Use DB
-- ============================================================================
USE open_review_platform;


-- =====================================================================
-- USER QUERIES
-- =====================================================================

-- PURPOSE: List all users in the system so the All Authors page can display them.
-- USED AT: http://localhost:8080/authors
SELECT userId, username, firstName, lastName, institution, role
FROM user
ORDER BY lastName ASC, firstName ASC;

-- PURPOSE: Get all users with a specific role (reviewers, authors, admins).
-- USED AT: internal service calls for reviewer selection, admin pages
SELECT userId, username, firstName, lastName, institution, role
FROM user
WHERE role = ?
ORDER BY lastName ASC, firstName ASC;

-- PURPOSE: Register a new user into the platform.
-- USED AT: http://localhost:8080/register (POST)
INSERT INTO user (username, password, firstName, lastName, institution, role)
VALUES (?, ?, ?, ?, ?, ?);

-- PURPOSE: Fetch a specific user's profile information by userId.
-- USED AT: http://localhost:8080/profile/{userId}
SELECT userId, username, firstName, lastName, institution, role
FROM user
WHERE userId = ?;

-- PURPOSE: Authenticate a user by username during login.
-- USED AT: http://localhost:8080/login (POST)
SELECT userId, username, password, firstName, lastName, institution, role
FROM user
WHERE username = ?;



-- =====================================================================
-- PAPER QUERIES
-- =====================================================================

-- PURPOSE: Fetch full paper details including scores for the paper_page view.
-- USED AT: http://localhost:8080/paper/{paperId}
SELECT p.paperId,
       p.title,
       p.authors,
       p.abstract AS abstractText,
       p.filePath,
       DATE_FORMAT(CONVERT_TZ(p.uploadedAt, '+00:00', '-04:00'),
                   '%b %e, %Y %l:%i %p') AS uploadDate,
       p.uploaderId,
       COALESCE(AVG(r.overallScore), 0) AS avgScore,
       COUNT(r.reviewId) AS reviewCount
FROM paper p
LEFT JOIN review r ON r.paperId = p.paperId
WHERE p.paperId = ?
GROUP BY p.paperId, p.title, abstractText, p.authors,
         p.filePath, p.uploadedAt, uploadDate, p.uploaderId;

-- PURPOSE: Retrieve the filePath for a PDF and stream it to the browser.
-- USED AT: http://localhost:8080/paper/{paperId}/pdf
SELECT filePath FROM paper WHERE paperId = ?;

-- PURPOSE: Fetch all papers for the homepage and All Papers page.
-- USED AT: http://localhost:8080/, http://localhost:8080/papers
SELECT p.paperId,
       p.title,
       p.authors,
       p.abstract AS abstractText,
       DATE_FORMAT(CONVERT_TZ(p.uploadedAt, '+00:00', '-04:00'),
                   '%b %e, %Y %l:%i %p') AS uploadDate,
       p.uploaderId,
       COALESCE(AVG(r.overallScore), 0) AS avgScore,
       COUNT(r.reviewId) AS reviewCount
FROM paper p
LEFT JOIN review r ON r.paperId = p.paperId
GROUP BY p.paperId, p.title, abstractText, p.authors,
         p.uploadedAt, uploadDate, p.uploaderId
ORDER BY p.uploadedAt DESC;

-- PURPOSE: Search papers by title, authors, or abstract.
-- USED AT: http://localhost:8080/search
SELECT 
    p.paperId,
    p.title,
    p.authors,
    p.abstract AS abstractText,
    DATE_FORMAT(CONVERT_TZ(p.uploadedAt, '+00:00', '-04:00'),
                '%b %e, %Y %l:%i %p') AS uploadDate,
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
WHERE LOWER(p.title) LIKE LOWER(?)
   OR LOWER(p.authors) LIKE LOWER(?)
   OR LOWER(p.abstract) LIKE LOWER(?)
GROUP BY p.paperId, p.title, abstractText, uploadDate,
         u.userId, u.firstName, u.lastName,
         u.role, u.institution, u.profileImagePath
ORDER BY p.uploadedAt DESC;



-- =====================================================================
-- COMMENT / DISCUSSION QUERIES
-- =====================================================================

-- PURPOSE: Fetch all comments for a paper's discussion section.
-- USED AT: http://localhost:8080/paper/{paperId} → Discussion tab
SELECT c.commentId,
       c.userId,
       c.content,
       DATE_FORMAT(CONVERT_TZ(c.createdAt, '+00:00', '-04:00'),
                   '%b %e, %Y %l:%i %p') AS createdAt
FROM comment c
WHERE c.paperId = ?
ORDER BY c.createdAt ASC;

-- PURPOSE: Add a new public comment to a paper discussion thread.
-- USED AT: http://localhost:8080/paper/{paperId}/comment (POST)
INSERT INTO comment (paperId, userId, content)
VALUES (?, ?, ?);



-- =====================================================================
-- REVIEW QUERIES
-- =====================================================================

-- PURPOSE: Submit a review (without per-criterion scores).
-- USED AT: http://localhost:8080/paper/{paperId}/review (POST)
INSERT INTO review (paperId, reviewerId, overallScore, confidence, verdict, feedback)
VALUES (?, ?, ?, ?, ?, ?);

-- PURPOSE: Submit per-criterion review scores linked to a review.
-- USED AT: http://localhost:8080/paper/{paperId}/review (POST)
INSERT INTO review_criterion_score (reviewId, criterionId, score)
VALUES (?, ?, ?);

-- PURPOSE: Load all reviews for a paper for the Review tab.
-- USED AT: http://localhost:8080/paper/{paperId}
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

-- PURPOSE: Load all reviews written by a particular reviewer.
-- USED AT: reviewer dashboards, profile pages
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

-- PURPOSE: Fetch detailed per-criterion scoring for a specific review.
-- USED AT: http://localhost:8080/paper/{paperId} → Review details
SELECT reviewId, criterionId, score
FROM review_criterion_score
WHERE reviewId = ?;


