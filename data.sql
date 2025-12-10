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
 'Cara', 'Chen', 'author', 'Georgia Tech'),

-- New author users (all use password "password123")
('weiqi.wang',     '$2a$10$H/jN2sxd6yBvDN3wyKvL2.KHiB/YxYoT0kZd1.cwEQZ5h4EJTlTIG',
 'Weiqi',          'Wang',   'author', 'Various'),
('bo.pan',         '$2a$10$H/jN2sxd6yBvDN3wyKvL2.KHiB/YxYoT0kZd1.cwEQZ5h4EJTlTIG',
 'Bo',             'Pan',    'author', 'Various'),
('srishti.gureja', '$2a$10$H/jN2sxd6yBvDN3wyKvL2.KHiB/YxYoT0kZd1.cwEQZ5h4EJTlTIG',
 'Srishti',        'Gureja', 'author', 'Various'),
('xinwei.yang',    '$2a$10$H/jN2sxd6yBvDN3wyKvL2.KHiB/YxYoT0kZd1.cwEQZ5h4EJTlTIG',
 'Xinwei',         'Yang',   'author', 'Various'),
('jacy.anthis',    '$2a$10$H/jN2sxd6yBvDN3wyKvL2.KHiB/YxYoT0kZd1.cwEQZ5h4EJTlTIG',
 'Jacy Reese',     'Anthis', 'author', 'Various'),
('ermo.hua',       '$2a$10$H/jN2sxd6yBvDN3wyKvL2.KHiB/YxYoT0kZd1.cwEQZ5h4EJTlTIG',
 'Ermo',           'Hua',    'author', 'Various'),
('kristian.lum',   '$2a$10$H/jN2sxd6yBvDN3wyKvL2.KHiB/YxYoT0kZd1.cwEQZ5h4EJTlTIG',
 'Kristian',       'Lum',    'author', 'Various'),
('wenhan.liu',     '$2a$10$H/jN2sxd6yBvDN3wyKvL2.KHiB/YxYoT0kZd1.cwEQZ5h4EJTlTIG',
 'Wenhan',         'Liu',    'author', 'Various'),
('aaron.nicolson', '$2a$10$H/jN2sxd6yBvDN3wyKvL2.KHiB/YxYoT0kZd1.cwEQZ5h4EJTlTIG',
 'Aaron',          'Nicolson','author','Various'),
('jingheng.ye',    '$2a$10$H/jN2sxd6yBvDN3wyKvL2.KHiB/YxYoT0kZd1.cwEQZ5h4EJTlTIG',
 'Jingheng',       'Ye',     'author', 'Various'),
('junlin.li',      '$2a$10$H/jN2sxd6yBvDN3wyKvL2.KHiB/YxYoT0kZd1.cwEQZ5h4EJTlTIG',
 'Junlin',         'Li',     'author', 'Various'),
('zhouhong.gu',    '$2a$10$H/jN2sxd6yBvDN3wyKvL2.KHiB/YxYoT0kZd1.cwEQZ5h4EJTlTIG',
 'Zhouhong',       'Gu',     'author', 'Various'),
('haokun.liu',     '$2a$10$H/jN2sxd6yBvDN3wyKvL2.KHiB/YxYoT0kZd1.cwEQZ5h4EJTlTIG',
 'Haokun',         'Liu',    'author', 'Various'),
('ziyang.luo',     '$2a$10$H/jN2sxd6yBvDN3wyKvL2.KHiB/YxYoT0kZd1.cwEQZ5h4EJTlTIG',
 'Ziyang',         'Luo',    'author', 'Various'),
('seunguk.yu',     '$2a$10$H/jN2sxd6yBvDN3wyKvL2.KHiB/YxYoT0kZd1.cwEQZ5h4EJTlTIG',
 'Seunguk',        'Yu',     'author', 'Various'),
('dosung.lee',     '$2a$10$H/jN2sxd6yBvDN3wyKvL2.KHiB/YxYoT0kZd1.cwEQZ5h4EJTlTIG',
 'Dosung',         'Lee',    'author', 'Various'),
('yin.cai',        '$2a$10$H/jN2sxd6yBvDN3wyKvL2.KHiB/YxYoT0kZd1.cwEQZ5h4EJTlTIG',
 'Yin',            'Cai',    'author', 'Various'),
('hongzhan.lin',   '$2a$10$H/jN2sxd6yBvDN3wyKvL2.KHiB/YxYoT0kZd1.cwEQZ5h4EJTlTIG',
 'Hongzhan',       'Lin',    'author', 'Various'),
('loic.fosse',     '$2a$10$H/jN2sxd6yBvDN3wyKvL2.KHiB/YxYoT0kZd1.cwEQZ5h4EJTlTIG',
 'Loic',           'Fosse',  'author', 'Various')
ON DUPLICATE KEY UPDATE username = username;


-- Lookup user IDs
SET @alice    := (SELECT userId FROM user WHERE username='alice');
SET @bob      := (SELECT userId FROM user WHERE username='bob');
SET @cara     := (SELECT userId FROM user WHERE username='cara');

SET @weiqi    := (SELECT userId FROM user WHERE username='weiqi.wang');
SET @bo       := (SELECT userId FROM user WHERE username='bo.pan');
SET @srishti  := (SELECT userId FROM user WHERE username='srishti.gureja');
SET @xinwei   := (SELECT userId FROM user WHERE username='xinwei.yang');
SET @jacy     := (SELECT userId FROM user WHERE username='jacy.anthis');
SET @ermo     := (SELECT userId FROM user WHERE username='ermo.hua');
SET @kristian := (SELECT userId FROM user WHERE username='kristian.lum');
SET @wenhan   := (SELECT userId FROM user WHERE username='wenhan.liu');
SET @aaron    := (SELECT userId FROM user WHERE username='aaron.nicolson');
SET @jingheng := (SELECT userId FROM user WHERE username='jingheng.ye');
SET @junlin   := (SELECT userId FROM user WHERE username='junlin.li');
SET @zhouhong := (SELECT userId FROM user WHERE username='zhouhong.gu');
SET @haokun   := (SELECT userId FROM user WHERE username='haokun.liu');
SET @ziyang   := (SELECT userId FROM user WHERE username='ziyang.luo');
SET @seunguk  := (SELECT userId FROM user WHERE username='seunguk.yu');
SET @dosung   := (SELECT userId FROM user WHERE username='dosung.lee');
SET @yin      := (SELECT userId FROM user WHERE username='yin.cai');
SET @hongzhan := (SELECT userId FROM user WHERE username='hongzhan.lin');
SET @loic     := (SELECT userId FROM user WHERE username='loic.fosse');


-- ============================================================================
-- PAPERS 
-- ============================================================================

INSERT INTO paper (title, abstract, authors, uploaderId, filePath)
VALUES
('Deep Learning on Traffic Prediction: Methods, Analysis and Future Directions',
 'We propose an LSTM–GNN hybrid model improving city-scale traffic forecasting accuracy.',
 'Alice Anderson',
 @alice,
 '/uploads/paper1.pdf'),

('Accelerating Scientific Discovery with Generative Knowledge Extraction, Graph-Based Representation, and Multimodal Intelligent Graph Reasoning',
 'A survey of neural models for structured information extraction from research papers.',
 'Cara Chen',
 @cara,
 '/uploads/paper2.pdf'),

('S*: Test Time Scaling for Code Generation',
 'We propose running, validating, and repairing model-generated code in a multi-stage loop.',
 'Alice Anderson',
 @alice,
 '/uploads/paper3.pdf'),

('Understanding Privacy Risks in Code Models Through Training Dynamics: A Causal Approach',
 'We introduce a benchmark for how variable renaming affects LLM correctness.',
 'Bob Baker',
 @bob,
 '/uploads/paper4.pdf'),

('Parameter-Efficient Fine-Tuning Methods for Pretrained Language Models: A Critical Review and Assessment',
 'A comparison of LoRA, QLoRA, and adapters with efficiency and accuracy trade-offs.',
 'Cara Chen',
 @cara,
 '/uploads/paper5.pdf'),

('Contrastive Learning Using Graph Embeddings for Domain Adaptation of Language Models in the Process Industry',
 'We explore contrastive objectives for creating general-purpose embeddings for research text.',
 'Cara Chen',
 @cara,
 '/uploads/paper6.pdf'),

('KA-GNN: Kolmogorov-Arnold Graph Neural Networks for Molecular Property Prediction',
 'A study of message-passing neural networks for chemistry and drug discovery.',
 'Alice Anderson',
 @alice,
 '/uploads/paper7.pdf'),

('Benchmarks and Metrics for Evaluations of Code Generation: A Critical Review',
 'We build a dataset focusing on runtime failures to evaluate debugging ability in LLMs.',
 'Bob Baker',
 @bob,
 '/uploads/paper8.pdf'),

('AI and the Future of Academic Peer Review',
 'We analyze trends toward machine-assisted peer review and evaluation criteria.',
 'Ermo Hua',
 @ermo,
 '/uploads/paper9.pdf'),

('Synthetic Time Series Forecasting with Transformer Architectures: Extensive Simulation Benchmarks',
 'A comprehensive survey evaluating Transformers vs classical forecasting models.',
 'Cara Chen',
 @cara,
 '/uploads/paper10.pdf'),

('EcomScriptBench: A Multi-task Benchmark for E-commerce Script Planning via Step-wise Intention-Driven Product Association',
 'We introduce a benchmark for decomposing e-commerce scripts into intention-driven product actions.',
 'Weiqi Wang',
 @weiqi,
 '/uploads/paper11.pdf'),

('TAGExplainer: Narrating Graph Explanations for Text-Attributed Graph Learning Models',
 'We present a system that turns graph model explanations into natural-language narratives over text-attributed graphs.',
 'Bo Pan',
 @bo,
 '/uploads/paper12.pdf'),

('M-RewardBench: Evaluating Reward Models in Multilingual Settings',
 'We build a multilingual benchmark to systematically evaluate reward models across languages.',
 'Srishti Gureja',
 @srishti,
 '/uploads/paper13.pdf'),

('ELABORATION: A Comprehensive Benchmark on Human-LLM Competitive Programming',
 'We construct a large-scale benchmark to study human-LLM competition on programming tasks.',
 'Xinwei Yang',
 @xinwei,
 '/uploads/paper14.pdf'),

('The Impossibility of Fair LLMs',
 'We analyze fundamental trade-offs that make perfectly fair large language models impossible.',
 'Jacy Reese Anthis',
 @jacy,
 '/uploads/paper15.pdf'),

('Intuitive Fine-Tuning: Towards Simplifying Alignment into a Single Process',
 'We propose a simplified alignment pipeline that unifies multiple tuning stages into a single intuitive process.',
 'Ermo Hua',
 @ermo,
 '/uploads/paper16.pdf'),

('Bias in Language Models: Beyond Trick Tests and Towards RUTEd Evaluation',
 'We argue for robust, use-case-grounded evaluations of bias via the RUTEd framework.',
 'Kristian Lum',
 @kristian,
 '/uploads/paper17.pdf'),

('Sliding Windows Are Not the End: Exploring Full Ranking with Long-Context Large Language Models',
 'We explore long-context ranking strategies that go beyond simple sliding-window truncation.',
 'Wenhan Liu',
 @wenhan,
 '/uploads/paper18.pdf'),

('The Impact of Auxiliary Patient Data on Automated Chest X-Ray Report Generation and How to Incorporate It',
 'We study how auxiliary patient data affects chest X-ray report generation and propose integration strategies.',
 'Aaron Nicolson',
 @aaron,
 '/uploads/paper19.pdf'),

('CLEME2.0: Towards Interpretable Evaluation by Disentangling Edits for Grammatical Error Correction',
 'We extend a grammatical error correction benchmark with disentangled edit-level evaluation.',
 'Jingheng Ye',
 @jingheng,
 '/uploads/paper20.pdf'),

('Towards LLM-powered Attentive Listener: A Pragmatic Approach through Quantity Self-Repair',
 'We model attentive listening behavior via quantity self-repair mechanisms in LLMs.',
 'Junlin Li',
 @junlin,
 '/uploads/paper21.pdf'),

('StrucText-Eval: Evaluating Large Language Model’s Reasoning Ability in Structure-Rich Text',
 'We benchmark LLM reasoning on structure-rich text such as tables, forms, and logs.',
 'Zhouhong Gu',
 @zhouhong,
 '/uploads/paper22.pdf'),

('Literature Meets Data: A Synergistic Approach to Hypothesis Generation',
 'We combine scientific literature mining with data-driven methods to generate new research hypotheses.',
 'Haokun Liu',
 @haokun,
 '/uploads/paper23.pdf'),

('GAPO: Learning Preferential Prompt through Generative Adversarial Policy Optimization',
 'We learn preferential prompts via generative adversarial policy optimization.',
 'Zhouhong Gu',
 @zhouhong,
 '/uploads/paper24.pdf'),

('Tree-of-Evolution: Tree-Structured Instruction Evolution for Code Generation in Large Language Models',
 'We evolve code generation instructions in a tree-structured manner to improve LLM coding abilities.',
 'Ziyang Luo',
 @ziyang,
 '/uploads/paper25.pdf'),

('Delving into Multilingual Ethical Bias: The MSQAD with Statistical Hypothesis Tests for Large Language Models',
 'We introduce MSQAD to measure multilingual ethical bias using statistical hypothesis tests.',
 'Seunguk Yu',
 @seunguk,
 '/uploads/paper26.pdf'),

('ReSCORE: Label-free Iterative Retriever Training for Multi-hop Question Answering with Relevance-Consistency Supervision',
 'We propose label-free iterative retriever training guided by relevance-consistency signals.',
 'Dosung Lee',
 @dosung,
 '/uploads/paper27.pdf'),

('MIRAGE: Exploring How Large Language Models Perform in Complex Social Interactive Environments',
 'We evaluate how LLMs behave in complex, multi-agent social interaction environments.',
 'Yin Cai',
 @yin,
 '/uploads/paper28.pdf'),

('FACT-AUDIT: An Adaptive Multi-Agent Framework for Dynamic Fact-Checking Evaluation of Large Language Models',
 'We design a multi-agent framework for dynamic fact-checking of LLM generations.',
 'Hongzhan Lin',
 @hongzhan,
 '/uploads/paper29.pdf'),

('Statistical Deficiency for Task Inclusion Estimation',
 'We formulate task inclusion estimation as a problem of statistical deficiency.',
 'Loic Fosse',
 @loic,
 '/uploads/paper30.pdf')
ON DUPLICATE KEY UPDATE title = title;



-- Lookup paper IDs

SET @p1  := (SELECT paperId FROM paper WHERE title = 'Deep Learning on Traffic Prediction: Methods, Analysis and Future Directions' LIMIT 1);
SET @p2  := (SELECT paperId FROM paper WHERE title = 'Accelerating Scientific Discovery with Generative Knowledge Extraction, Graph-Based Representation, and Multimodal Intelligent Graph Reasoning' LIMIT 1);
SET @p3  := (SELECT paperId FROM paper WHERE title = 'S*: Test Time Scaling for Code Generation' LIMIT 1);
SET @p4  := (SELECT paperId FROM paper WHERE title = 'Understanding Privacy Risks in Code Models Through Training Dynamics: A Causal Approach' LIMIT 1);
SET @p5  := (SELECT paperId FROM paper WHERE title = 'Parameter-Efficient Fine-Tuning Methods for Pretrained Language Models: A Critical Review and Assessment' LIMIT 1);
SET @p6  := (SELECT paperId FROM paper WHERE title = 'Contrastive Learning Using Graph Embeddings for Domain Adaptation of Language Models in the Process Industry' LIMIT 1);
SET @p7  := (SELECT paperId FROM paper WHERE title = 'KA-GNN: Kolmogorov-Arnold Graph Neural Networks for Molecular Property Prediction' LIMIT 1);
SET @p8  := (SELECT paperId FROM paper WHERE title = 'Benchmarks and Metrics for Evaluations of Code Generation: A Critical Review' LIMIT 1);
SET @p9  := (SELECT paperId FROM paper WHERE title = 'AI and the Future of Academic Peer Review' LIMIT 1);
SET @p10 := (SELECT paperId FROM paper WHERE title = 'Synthetic Time Series Forecasting with Transformer Architectures: Extensive Simulation Benchmarks' LIMIT 1);

SET @p11 := (SELECT paperId FROM paper WHERE title = 'EcomScriptBench: A Multi-task Benchmark for E-commerce Script Planning via Step-wise Intention-Driven Product Association' LIMIT 1);
SET @p12 := (SELECT paperId FROM paper WHERE title = 'TAGExplainer: Narrating Graph Explanations for Text-Attributed Graph Learning Models' LIMIT 1);
SET @p13 := (SELECT paperId FROM paper WHERE title = 'M-RewardBench: Evaluating Reward Models in Multilingual Settings' LIMIT 1);
SET @p14 := (SELECT paperId FROM paper WHERE title = 'ELABORATION: A Comprehensive Benchmark on Human-LLM Competitive Programming' LIMIT 1);
SET @p15 := (SELECT paperId FROM paper WHERE title = 'The Impossibility of Fair LLMs' LIMIT 1);
SET @p16 := (SELECT paperId FROM paper WHERE title = 'Intuitive Fine-Tuning: Towards Simplifying Alignment into a Single Process' LIMIT 1);
SET @p17 := (SELECT paperId FROM paper WHERE title = 'Bias in Language Models: Beyond Trick Tests and Towards RUTEd Evaluation' LIMIT 1);
SET @p18 := (SELECT paperId FROM paper WHERE title = 'Sliding Windows Are Not the End: Exploring Full Ranking with Long-Context Large Language Models' LIMIT 1);
SET @p19 := (SELECT paperId FROM paper WHERE title = 'The Impact of Auxiliary Patient Data on Automated Chest X-Ray Report Generation and How to Incorporate It' LIMIT 1);
SET @p20 := (SELECT paperId FROM paper WHERE title = 'CLEME2.0: Towards Interpretable Evaluation by Disentangling Edits for Grammatical Error Correction' LIMIT 1);

SET @p21 := (SELECT paperId FROM paper WHERE title = 'Towards LLM-powered Attentive Listener: A Pragmatic Approach through Quantity Self-Repair' LIMIT 1);
SET @p22 := (SELECT paperId FROM paper WHERE title = 'StrucText-Eval: Evaluating Large Language Model’s Reasoning Ability in Structure-Rich Text' LIMIT 1);
SET @p23 := (SELECT paperId FROM paper WHERE title = 'Literature Meets Data: A Synergistic Approach to Hypothesis Generation' LIMIT 1);
SET @p24 := (SELECT paperId FROM paper WHERE title = 'GAPO: Learning Preferential Prompt through Generative Adversarial Policy Optimization' LIMIT 1);
SET @p25 := (SELECT paperId FROM paper WHERE title = 'Tree-of-Evolution: Tree-Structured Instruction Evolution for Code Generation in Large Language Models' LIMIT 1);
SET @p26 := (SELECT paperId FROM paper WHERE title = 'Delving into Multilingual Ethical Bias: The MSQAD with Statistical Hypothesis Tests for Large Language Models' LIMIT 1);
SET @p27 := (SELECT paperId FROM paper WHERE title = 'ReSCORE: Label-free Iterative Retriever Training for Multi-hop Question Answering with Relevance-Consistency Supervision' LIMIT 1);
SET @p28 := (SELECT paperId FROM paper WHERE title = 'MIRAGE: Exploring How Large Language Models Perform in Complex Social Interactive Environments' LIMIT 1);
SET @p29 := (SELECT paperId FROM paper WHERE title = 'FACT-AUDIT: An Adaptive Multi-Agent Framework for Dynamic Fact-Checking Evaluation of Large Language Models' LIMIT 1);
SET @p30 := (SELECT paperId FROM paper WHERE title = 'Statistical Deficiency for Task Inclusion Estimation' LIMIT 1);




-- ============================================================================
-- SIMPLE REVIEWS (sample)
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
