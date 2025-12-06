USE open_review_platform;

-- ============================================================================
-- USERS (admin, authors, reviewers)
-- Password hash = "password123" (bcrypt)
-- ============================================================================

INSERT INTO user (username, password, firstName, lastName, role, institution)
VALUES
('admin', '$2a$10$H/jN2sxd6yBvDN3wyKvL2.KHiB/YxYoT0kZd1.cwEQZ5h4EJTlTIG',
 'System', 'Admin', 'admin', 'UGA'),

('alice', '$2a$10$H/jN2sxd6yBvDN3wyKvL2.KHiB/YxYoT0kZd1.cwEQZ5h4EJTlTIG',
 'Alice', 'Anderson', 'author', 'MIT'),

('bob',   '$2a$10$H/jN2sxd6yBvDN3wyKvL2.KHiB/YxYoT0kZd1.cwEQZ5h4EJTlTIG',
 'Bob', 'Baker', 'reviewer', 'Stanford'),

('cara',  '$2a$10$H/jN2sxd6yBvDN3wyKvL2.KHiB/YxYoT0kZd1.cwEQZ5h4EJTlTIG',
 'Cara', 'Chen', 'author', 'Georgia Tech')
ON DUPLICATE KEY UPDATE username = username;


-- Lookup user IDs
SET @admin := (SELECT userId FROM user WHERE username='admin');
SET @alice := (SELECT userId FROM user WHERE username='alice');
SET @bob   := (SELECT userId FROM user WHERE username='bob');
SET @cara  := (SELECT userId FROM user WHERE username='cara');


-- ============================================================================
-- PAPERS (Original + 5 Extra Papers)
-- ============================================================================

INSERT INTO paper (title, abstract, authors, uploaderId, filePath)
VALUES
('A Deep Learning Model for Traffic Prediction',
 'We propose an LSTM–GNN hybrid model improving city-scale traffic forecasting accuracy.',
 'Alice Anderson',
 @alice,
 '/uploads/paper1.pdf'),

('Neural Approaches to Scientific Knowledge Extraction',
 'A survey of neural models for structured information extraction from research papers.',
 'Cara Chen',
 @cara,
 '/uploads/paper2.pdf'),

('Execution-Grounded Code Generation: A New Reliability Paradigm',
 'We propose running, validating, and repairing model-generated code in a multi-stage loop.',
 'Alice Anderson',
 @alice,
 '/uploads/paper3.pdf'),

('Understanding Variable Name Sensitivity in Code Models',
 'We introduce a benchmark for how variable renaming affects LLM correctness.',
 'Bob Baker',
 @bob,
 '/uploads/paper4.pdf'),

('Efficient Fine-Tuning Methods for Large Transformers',
 'A comparison of LoRA, QLoRA, and adapters with efficiency and accuracy trade-offs.',
 'System Admin',
 @admin,
 '/uploads/paper5.pdf'),

-- Extra papers (5 new)
('Contrastive Learning for Scientific Embedding Models',
 'We explore contrastive objectives for creating general-purpose embeddings for research text.',
 'Cara Chen',
 @cara,
 '/uploads/paper6.pdf'),

('Graph Neural Networks for Molecular Property Prediction',
 'A study of message-passing neural networks for chemistry and drug discovery.',
 'Alice Anderson',
 @alice,
 '/uploads/paper7.pdf'),

('A Lightweight Benchmark for Code Execution Errors',
 'We build a dataset focusing on runtime failures to evaluate debugging ability in LLMs.',
 'Bob Baker',
 @bob,
 '/uploads/paper8.pdf'),

('Survey: The Future of Automated Peer Review',
 'We analyze trends toward machine-assisted peer review and evaluation criteria.',
 'System Admin',
 @admin,
 '/uploads/paper9.pdf'),

('Transformer Models for Time Series Forecasting',
 'A comprehensive survey evaluating Transformers vs classical forecasting models.',
 'Cara Chen',
 @cara,
 '/uploads/paper10.pdf')
ON DUPLICATE KEY UPDATE title = title;


-- Lookup paper IDs
SET @p1 := (SELECT paperId FROM paper WHERE title LIKE 'A Deep Learning%' LIMIT 1);
SET @p2 := (SELECT paperId FROM paper WHERE title LIKE 'Neural Approaches%' LIMIT 1);
SET @p3 := (SELECT paperId FROM paper WHERE title LIKE 'Execution-Grounded%' LIMIT 1);
SET @p4 := (SELECT paperId FROM paper WHERE title LIKE 'Understanding Variable%' LIMIT 1);
SET @p5 := (SELECT paperId FROM paper WHERE title LIKE 'Efficient Fine-Tuning%' LIMIT 1);


-- ============================================================================
-- COMMENTS (Discussion)
-- ============================================================================

INSERT INTO comment (paperId, userId, content)
VALUES
(@p1, @bob,  'This model looks promising. How large was the dataset?'),
(@p1, @cara, 'The architecture diagram is very clear.'),
(@p2, @alice,'Knowledge extraction is becoming very important!')
ON DUPLICATE KEY UPDATE content = content;


-- ============================================================================
-- SIMPLE REVIEWS (updated model — no criterion scores)
-- ============================================================================

INSERT INTO review (paperId, reviewerId, overallScore, confidence, verdict, feedback)
VALUES
(@p1, @bob, 
 5, 4, 'accept', 
 'Strong methodology and clear contribution.'),

(@p2, @bob,
 3, 3, 'borderline',
 'Good ideas, but needs stronger empirical results.')
ON DUPLICATE KEY UPDATE verdict = verdict;
