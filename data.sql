USE open_review_platform;

-- ============================================================================
-- USERS (admin, authors, reviewers)
-- Password hash = "test" (bcrypt)
-- ============================================================================

INSERT INTO user (username, password, firstName, lastName, role, institution)
VALUES
('admin', '$2a$10$E6IvIYTt6rDK569NbG2pIOUGFXAE2qWGQ8stTY1onNVLtunniUzRu',
 'System', 'Admin', 'admin', 'UGA'),

('alice', '$2a$10$E6IvIYTt6rDK569NbG2pIOUGFXAE2qWGQ8stTY1onNVLtunniUzRu',
 'Alice', 'Anderson', 'author', 'MIT'),

('bob',   '$2a$10$E6IvIYTt6rDK569NbG2pIOUGFXAE2qWGQ8stTY1onNVLtunniUzRu',
 'Bob', 'Baker', 'reviewer', 'Stanford'),

('cara',  '$2a$10$E6IvIYTt6rDK569NbG2pIOUGFXAE2qWGQ8stTY1onNVLtunniUzRu',
 'Cara', 'Chen', 'author', 'Georgia Tech'),

-- New author users (all use password "test")
('weiqi.wang',     '$2a$10$E6IvIYTt6rDK569NbG2pIOUGFXAE2qWGQ8stTY1onNVLtunniUzRu',
 'Weiqi',          'Wang',   'author', 'Various'),
('bo.pan',         '$2a$10$E6IvIYTt6rDK569NbG2pIOUGFXAE2qWGQ8stTY1onNVLtunniUzRu',
 'Bo',             'Pan',    'author', 'Various'),
('srishti.gureja', '$2a$10$E6IvIYTt6rDK569NbG2pIOUGFXAE2qWGQ8stTY1onNVLtunniUzRu',
 'Srishti',        'Gureja', 'author', 'Various'),
('xinwei.yang',    '$2a$10$E6IvIYTt6rDK569NbG2pIOUGFXAE2qWGQ8stTY1onNVLtunniUzRu',
 'Xinwei',         'Yang',   'author', 'Various'),
('jacy.anthis',    '$2a$10$E6IvIYTt6rDK569NbG2pIOUGFXAE2qWGQ8stTY1onNVLtunniUzRu',
 'Jacy Reese',     'Anthis', 'author', 'Various'),
('ermo.hua',       '$2a$10$E6IvIYTt6rDK569NbG2pIOUGFXAE2qWGQ8stTY1onNVLtunniUzRu',
 'Ermo',           'Hua',    'author', 'Various'),
('kristian.lum',   '$2a$10$E6IvIYTt6rDK569NbG2pIOUGFXAE2qWGQ8stTY1onNVLtunniUzRu',
 'Kristian',       'Lum',    'author', 'Various'),
('wenhan.liu',     '$2a$10$E6IvIYTt6rDK569NbG2pIOUGFXAE2qWGQ8stTY1onNVLtunniUzRu',
 'Wenhan',         'Liu',    'author', 'Various'),
('aaron.nicolson', '$2a$10$E6IvIYTt6rDK569NbG2pIOUGFXAE2qWGQ8stTY1onNVLtunniUzRu',
 'Aaron',          'Nicolson','author','Various'),
('jingheng.ye',    '$2a$10$E6IvIYTt6rDK569NbG2pIOUGFXAE2qWGQ8stTY1onNVLtunniUzRu',
 'Jingheng',       'Ye',     'author', 'Various'),
('junlin.li',      '$2a$10$E6IvIYTt6rDK569NbG2pIOUGFXAE2qWGQ8stTY1onNVLtunniUzRu',
 'Junlin',         'Li',     'author', 'Various'),
('zhouhong.gu',    '$2a$10$E6IvIYTt6rDK569NbG2pIOUGFXAE2qWGQ8stTY1onNVLtunniUzRu',
 'Zhouhong',       'Gu',     'author', 'Various'),
('haokun.liu',     '$2a$10$E6IvIYTt6rDK569NbG2pIOUGFXAE2qWGQ8stTY1onNVLtunniUzRu',
 'Haokun',         'Liu',    'author', 'Various'),
('ziyang.luo',     '$2a$10$E6IvIYTt6rDK569NbG2pIOUGFXAE2qWGQ8stTY1onNVLtunniUzRu',
 'Ziyang',         'Luo',    'author', 'Various'),
('seunguk.yu',     '$2a$10$E6IvIYTt6rDK569NbG2pIOUGFXAE2qWGQ8stTY1onNVLtunniUzRu',
 'Seunguk',        'Yu',     'author', 'Various'),
('dosung.lee',     '$2a$10$E6IvIYTt6rDK569NbG2pIOUGFXAE2qWGQ8stTY1onNVLtunniUzRu',
 'Dosung',         'Lee',    'author', 'Various'),
('yin.cai',        '$2a$10$E6IvIYTt6rDK569NbG2pIOUGFXAE2qWGQ8stTY1onNVLtunniUzRu',
 'Yin',            'Cai',    'author', 'Various'),
('hongzhan.lin',   '$2a$10$E6IvIYTt6rDK569NbG2pIOUGFXAE2qWGQ8stTY1onNVLtunniUzRu',
 'Hongzhan',       'Lin',    'author', 'Various'),
('loic.fosse',     '$2a$10$E6IvIYTt6rDK569NbG2pIOUGFXAE2qWGQ8stTY1onNVLtunniUzRuG',
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

-- AUTO-GENERATED SAMPLE PAPERS

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Teaching CS50 with AI: Leveraging Generative Artificial Intelligence in Computer Science Education', 'Placeholder abstract for sample data.', 'Xinwei Yang', @dosung, '/uploads/sample_paper_1.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Computer Science Curricula 2023', 'Placeholder abstract for sample data.', 'Bo Pan', @xinwei, '/uploads/sample_paper_2.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Algorithms on Strings, Trees, and Sequences - Computer Science and Computational Biology', 'Placeholder abstract for sample data.', 'Kristian Lum', @haokun, '/uploads/sample_paper_3.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Multiobjective Optimization Interactive And Evolutionary Approaches Lecture Notes In Computer Science Theoretical Computer Science And General Issues', 'Placeholder abstract for sample data.', 'Srishti Gureja', @jacy, '/uploads/sample_paper_4.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Calibration of the Computer Science and Applications, Inc. accelerometer.', 'Placeholder abstract for sample data.', 'Seunguk Yu', @srishti, '/uploads/sample_paper_5.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Gender stereotypes about interests start early and cause gender disparities in computer science and engineering', 'Placeholder abstract for sample data.', 'Alice Anderson', @weiqi, '/uploads/sample_paper_6.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('An introduction to computer science for non-majors using principles of computation', 'Placeholder abstract for sample data.', 'Bo Pan', @seunguk, '/uploads/sample_paper_7.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('A critical review of literature on “unplugged” pedagogies in K-12 computer science and computational thinking education', 'Placeholder abstract for sample data.', 'Haokun Liu', @haokun, '/uploads/sample_paper_8.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Virtual Reality in Computer Science Education: A Systematic Review', 'Placeholder abstract for sample data.', 'Zhouhong Gu', @ermo, '/uploads/sample_paper_9.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Identifying the Prevalence of the Impostor Phenomenon Among Computer Science Students', 'Placeholder abstract for sample data.', 'Haokun Liu', @seunguk, '/uploads/sample_paper_10.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Engaging Equity Pedagogies in Computer Science Learning Environments', 'Placeholder abstract for sample data.', 'Junlin Li', @bo, '/uploads/sample_paper_11.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Threats of a replication crisis in empirical computer science', 'Placeholder abstract for sample data.', 'Ermo Hua', @dosung, '/uploads/sample_paper_12.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Encyclopedia of Computer Science and Technology', 'Placeholder abstract for sample data.', 'Seunguk Yu', @cara, '/uploads/sample_paper_13.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Concrete mathematics - a foundation for computer science', 'Placeholder abstract for sample data.', 'Hongzhan Lin', @kristian, '/uploads/sample_paper_14.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Coding as another language: a pedagogical approach for teaching computer science in early childhood', 'Placeholder abstract for sample data.', 'Aaron Nicolson', @cara, '/uploads/sample_paper_15.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Pedagogy that Supports Computer Science for All', 'Placeholder abstract for sample data.', 'Seunguk Yu', @yin, '/uploads/sample_paper_16.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Lecture Notes in Computer Science (including subseries Lecture Notes in Artificial Intelligence and Lecture Notes in Bioinformatics)', 'Placeholder abstract for sample data.', 'Srishti Gureja', @zhouhong, '/uploads/sample_paper_17.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Translational Research in Computer Science', 'Placeholder abstract for sample data.', 'Hongzhan Lin', @bo, '/uploads/sample_paper_18.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Block-based programming in computer science education', 'Placeholder abstract for sample data.', 'Srishti Gureja', @haokun, '/uploads/sample_paper_19.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('A content-based recommender system for computer science publications', 'Placeholder abstract for sample data.', 'Zhouhong Gu', @wenhan, '/uploads/sample_paper_20.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Computer Science Pedagogical Content Knowledge', 'Placeholder abstract for sample data.', 'Bo Pan', @kristian, '/uploads/sample_paper_21.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Probability and Statistics with Reliability, Queuing, and Computer Science Applications', 'Placeholder abstract for sample data.', 'Alice Anderson', @weiqi, '/uploads/sample_paper_22.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Universal Algebra and Applications in Theoretical Computer Science', 'Placeholder abstract for sample data.', 'Xinwei Yang', @aaron, '/uploads/sample_paper_23.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Computing Whether She Belongs: Stereotypes Undermine Girls’ Interest and Sense of Belonging in Computer Science', 'Placeholder abstract for sample data.', 'Ziyang Luo', @hongzhan, '/uploads/sample_paper_24.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Handbook of theoretical computer science - Part A: Algorithms and complexity; Part B: Formal models and semantics', 'Placeholder abstract for sample data.', 'Ziyang Luo', @aaron, '/uploads/sample_paper_25.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Mathematical Logic in Computer Science', 'Placeholder abstract for sample data.', 'Jacy Reese Anthis', @weiqi, '/uploads/sample_paper_26.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Computational social science ≠ computer science + social data', 'Placeholder abstract for sample data.', 'Srishti Gureja', @bo, '/uploads/sample_paper_27.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Computer science and engineering', 'Placeholder abstract for sample data.', 'Junlin Li', @bo, '/uploads/sample_paper_28.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Anatomy of an Enduring Gender Gap: The Evolution of Women’s Participation in Computer Science', 'Placeholder abstract for sample data.', 'Wenhan Liu', @yin, '/uploads/sample_paper_29.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Some computer science issues in ubiquitous computing', 'Placeholder abstract for sample data.', 'Ermo Hua', @seunguk, '/uploads/sample_paper_30.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Advances in Intelligent Systems and Computing - Selected Papers from the International Conference on Computer Science and Information Technologies, CSIT 2016, September 6-10 Lviv, Ukraine', 'Placeholder abstract for sample data.', 'Ziyang Luo', @yin, '/uploads/sample_paper_31.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Logical Foundations of Computer Science', 'Placeholder abstract for sample data.', 'Ziyang Luo', @seunguk, '/uploads/sample_paper_32.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Cultural stereotypes as gatekeepers: increasing girls’ interest in computer science and engineering by diversifying stereotypes', 'Placeholder abstract for sample data.', 'Cara Chen', @wenhan, '/uploads/sample_paper_33.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Expanding computer science education in schools: understanding teacher experiences and challenges', 'Placeholder abstract for sample data.', 'Haokun Liu', @cara, '/uploads/sample_paper_34.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Computer science in K-12 school curricula of the 2lst century: Why, what and when?', 'Placeholder abstract for sample data.', 'Jingheng Ye', @hongzhan, '/uploads/sample_paper_35.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Computer science as empirical inquiry: symbols and search', 'Placeholder abstract for sample data.', 'Srishti Gureja', @loic, '/uploads/sample_paper_36.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Artificial intelligence and computer science in education: From kindergarten to university', 'Placeholder abstract for sample data.', 'Cara Chen', @hongzhan, '/uploads/sample_paper_37.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Diversity Barriers in K-12 Computer Science Education: Structural and Social', 'Placeholder abstract for sample data.', 'Junlin Li', @ziyang, '/uploads/sample_paper_38.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Visions of Computer Science Education: Unpacking Arguments for and Projected Impacts of CS4All Initiatives', 'Placeholder abstract for sample data.', 'Alice Anderson', @dosung, '/uploads/sample_paper_39.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Eliminating Gender Bias in Computer Science Education Materials', 'Placeholder abstract for sample data.', 'Kristian Lum', @alice, '/uploads/sample_paper_40.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('A review of models for introducing computational thinking, computer science and computing in K-12 education', 'Placeholder abstract for sample data.', 'Loic Fosse', @xinwei, '/uploads/sample_paper_41.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Bringing computational thinking to K-12: what is Involved and what is the role of the computer science education community?', 'Placeholder abstract for sample data.', 'Ermo Hua', @ziyang, '/uploads/sample_paper_42.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Expanding capacity and promoting inclusion in introductory computer science: a focus on near-peer mentor preparation and code review', 'Placeholder abstract for sample data.', 'Seunguk Yu', @cara, '/uploads/sample_paper_43.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Factors Influencing Computer Science Learning in Middle School', 'Placeholder abstract for sample data.', 'Weiqi Wang', @alice, '/uploads/sample_paper_44.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Girls and computer science: experiences, perceptions, and career aspirations', 'Placeholder abstract for sample data.', 'Aaron Nicolson', @jacy, '/uploads/sample_paper_45.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Developing a Computer Science Concept Inventory for Introductory Programming', 'Placeholder abstract for sample data.', 'Kristian Lum', @hongzhan, '/uploads/sample_paper_46.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Temporal Logics in Computer Science: Finite-State Systems', 'Placeholder abstract for sample data.', 'Ermo Hua', @haokun, '/uploads/sample_paper_47.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Women planning to major in computer science: Who are they and what makes them unique?', 'Placeholder abstract for sample data.', 'Hongzhan Lin', @loic, '/uploads/sample_paper_48.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Landscape of K-12 Computer Science Education in the U.S.: Perceptions, Access, and Barriers', 'Placeholder abstract for sample data.', 'Wenhan Liu', @junlin, '/uploads/sample_paper_49.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('"For all" in "computer science for all"', 'Placeholder abstract for sample data.', 'Loic Fosse', @zhouhong, '/uploads/sample_paper_50.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Computer Science for All', 'Placeholder abstract for sample data.', 'Weiqi Wang', @weiqi, '/uploads/sample_paper_51.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Evolutionary Multitasking: A Computer Science View of Cognitive Multitasking', 'Placeholder abstract for sample data.', 'Srishti Gureja', @cara, '/uploads/sample_paper_52.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Differentiating for Diversity: Using Universal Design for Learning in Elementary Computer Science Education', 'Placeholder abstract for sample data.', 'Jingheng Ye', @ermo, '/uploads/sample_paper_53.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Arguing for Computer Science in the School Curriculum', 'Placeholder abstract for sample data.', 'Cara Chen', @weiqi, '/uploads/sample_paper_54.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('The Case for Improving U.S. Computer Science Education', 'Placeholder abstract for sample data.', 'Zhouhong Gu', @alice, '/uploads/sample_paper_55.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Electronic Notes in Theoretical Computer Science', 'Placeholder abstract for sample data.', 'Xinwei Yang', @ziyang, '/uploads/sample_paper_56.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Game Development for Computer Science Education', 'Placeholder abstract for sample data.', 'Alice Anderson', @cara, '/uploads/sample_paper_57.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('How Early Does the CS Gender Gap Emerge?: A Study of Collaborative Problem Solving in 5th Grade Computer Science', 'Placeholder abstract for sample data.', 'Alice Anderson', @cara, '/uploads/sample_paper_58.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Is computing for social good the solution to closing the gender gap in computer science?', 'Placeholder abstract for sample data.', 'Wenhan Liu', @ermo, '/uploads/sample_paper_59.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('An evaluation of a professional learning network for computer science teachers', 'Placeholder abstract for sample data.', 'Cara Chen', @dosung, '/uploads/sample_paper_60.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Graph-Theoretic Concepts in Computer Science', 'Placeholder abstract for sample data.', 'Seunguk Yu', @kristian, '/uploads/sample_paper_61.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Designing for deeper learning in a blended computer science course for middle school students', 'Placeholder abstract for sample data.', 'Jingheng Ye', @hongzhan, '/uploads/sample_paper_62.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Digital Game-Based Learning in high school Computer Science education: Impact on educational effectiveness and student motivation', 'Placeholder abstract for sample data.', 'Bo Pan', @yin, '/uploads/sample_paper_63.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('A Pilot Computer Science and Programming Course for Primary School Students', 'Placeholder abstract for sample data.', 'Weiqi Wang', @alice, '/uploads/sample_paper_64.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Computer science teacher professional development in the United States: a review of studies published between 2004 and 2014', 'Placeholder abstract for sample data.', 'Zhouhong Gu', @alice, '/uploads/sample_paper_65.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Gender Differences in Factors Influencing Pursuit of Computer Science and Related Fields', 'Placeholder abstract for sample data.', 'Dosung Lee', @ziyang, '/uploads/sample_paper_66.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Probability, Statistics and Queueing Theory with Computer Science Applications', 'Placeholder abstract for sample data.', 'Junlin Li', @jingheng, '/uploads/sample_paper_67.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('A Global Snapshot of Computer Science Education in K-12 Schools', 'Placeholder abstract for sample data.', 'Srishti Gureja', @ziyang, '/uploads/sample_paper_68.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('It takes a village: supporting inquiry- and equity-oriented computer science pedagogy through a professional learning community', 'Placeholder abstract for sample data.', 'Seunguk Yu', @yin, '/uploads/sample_paper_69.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Conferences versus journals in computer science', 'Placeholder abstract for sample data.', 'Yin Cai', @weiqi, '/uploads/sample_paper_70.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('What is the best database for computer science journal articles?', 'Placeholder abstract for sample data.', 'Jingheng Ye', @jingheng, '/uploads/sample_paper_71.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('A Practical Guide to Developing and Validating Computer Science Knowledge Assessments with Application to Middle School', 'Placeholder abstract for sample data.', 'Ziyang Luo', @cara, '/uploads/sample_paper_72.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('The Role of Automation in Undergraduate Computer Science Education', 'Placeholder abstract for sample data.', 'Srishti Gureja', @loic, '/uploads/sample_paper_73.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Measures of Student Engagement in Computer Science', 'Placeholder abstract for sample data.', 'Haokun Liu', @ermo, '/uploads/sample_paper_74.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('The ongoing challenges of computer science education research', 'Placeholder abstract for sample data.', 'Jacy Reese Anthis', @zhouhong, '/uploads/sample_paper_75.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Why are women underrepresented in Computer Science? Gender differences in stereotypes, self-efficacy, values, and interests and predictors of future CS course-taking and grades', 'Placeholder abstract for sample data.', 'Weiqi Wang', @wenhan, '/uploads/sample_paper_76.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Restart: The Resurgence of Computer Science in UK Schools', 'Placeholder abstract for sample data.', 'Wenhan Liu', @kristian, '/uploads/sample_paper_77.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('A Case Study of the Introduction of Computer Science in NZ Schools', 'Placeholder abstract for sample data.', 'Cara Chen', @seunguk, '/uploads/sample_paper_78.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Ambient belonging: how stereotypical cues impact gender participation in computer science.', 'Placeholder abstract for sample data.', 'Aaron Nicolson', @weiqi, '/uploads/sample_paper_79.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Reviewing the flipped classroom research: reflections for computer science education', 'Placeholder abstract for sample data.', 'Haokun Liu', @srishti, '/uploads/sample_paper_80.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Curriculum is not enough: the educational theory and research foundation of the exploring computer science professional development model', 'Placeholder abstract for sample data.', 'Cara Chen', @junlin, '/uploads/sample_paper_81.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Computer science concept inventories: past and future', 'Placeholder abstract for sample data.', 'Yin Cai', @hongzhan, '/uploads/sample_paper_82.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Identifying computer science self-regulated learning strategies', 'Placeholder abstract for sample data.', 'Ermo Hua', @loic, '/uploads/sample_paper_83.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Collaboration, Collusion and Plagiarism in Computer Science Coursework.', 'Placeholder abstract for sample data.', 'Jacy Reese Anthis', @ziyang, '/uploads/sample_paper_84.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Computer Science Curricula 2013: Curriculum Guidelines for Undergraduate Degree Programs in Computer Science', 'Placeholder abstract for sample data.', 'Zhouhong Gu', @jacy, '/uploads/sample_paper_85.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Gamification for Engaging Computer Science Students in Learning Activities: A Case Study', 'Placeholder abstract for sample data.', 'Srishti Gureja', @ziyang, '/uploads/sample_paper_86.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Motivational active learning: engaging university students in computer science education', 'Placeholder abstract for sample data.', 'Bo Pan', @alice, '/uploads/sample_paper_87.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Remedying misperceptions of computer science among middle school students', 'Placeholder abstract for sample data.', 'Jingheng Ye', @aaron, '/uploads/sample_paper_88.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('The network of teaching excellence in computer science and master teachers', 'Placeholder abstract for sample data.', 'Ziyang Luo', @seunguk, '/uploads/sample_paper_89.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Computability, complexity, and languages - fundamentals of theoretical computer science', 'Placeholder abstract for sample data.', 'Hongzhan Lin', @bo, '/uploads/sample_paper_90.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('The science of fake news', 'Placeholder abstract for sample data.', 'Xinwei Yang', @jingheng, '/uploads/sample_paper_91.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Computer Science - Theory and Applications', 'Placeholder abstract for sample data.', 'Seunguk Yu', @wenhan, '/uploads/sample_paper_92.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Worked examples in computer science', 'Placeholder abstract for sample data.', 'Kristian Lum', @weiqi, '/uploads/sample_paper_93.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('What is Theoretical Computer Science', 'Placeholder abstract for sample data.', 'Weiqi Wang', @bo, '/uploads/sample_paper_94.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Computer science: The learning machines', 'Placeholder abstract for sample data.', 'Jingheng Ye', @jacy, '/uploads/sample_paper_95.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Writing for Computer Science', 'Placeholder abstract for sample data.', 'Ziyang Luo', @cara, '/uploads/sample_paper_96.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Khan academy gamifies computer science', 'Placeholder abstract for sample data.', 'Ermo Hua', @haokun, '/uploads/sample_paper_97.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Computer Science and Technology', 'Placeholder abstract for sample data.', 'Weiqi Wang', @alice, '/uploads/sample_paper_98.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Parameterized Complexity Theory (Texts in Theoretical Computer Science. An EATCS Series)', 'Placeholder abstract for sample data.', 'Aaron Nicolson', @junlin, '/uploads/sample_paper_99.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Computer Science & Information Technology (CS & IT)', 'Placeholder abstract for sample data.', 'Aaron Nicolson', @wenhan, '/uploads/sample_paper_100.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Nominal Sets: Names and Symmetry in Computer Science', 'Placeholder abstract for sample data.', 'Weiqi Wang', @haokun, '/uploads/sample_paper_101.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Theoretical Computer Science on the Complexity of Reconfiguration Problems', 'Placeholder abstract for sample data.', 'Weiqi Wang', @alice, '/uploads/sample_paper_102.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Computer Science Curricula 2013', 'Placeholder abstract for sample data.', 'Yin Cai', @xinwei, '/uploads/sample_paper_103.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Queueing Networks and Markov Chains (Modeling and Performance Evaluation With Computer Science Applications)', 'Placeholder abstract for sample data.', 'Weiqi Wang', @seunguk, '/uploads/sample_paper_104.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Enduring Influence of Stereotypical Computer Science Role Models on Women’s Academic Aspirations', 'Placeholder abstract for sample data.', 'Hongzhan Lin', @zhouhong, '/uploads/sample_paper_105.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('A curriculum for teaching computer science through computational textiles', 'Placeholder abstract for sample data.', 'Srishti Gureja', @junlin, '/uploads/sample_paper_106.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Bringing computer science back into schools: lessons from the UK', 'Placeholder abstract for sample data.', 'Ziyang Luo', @loic, '/uploads/sample_paper_107.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Assessment of computer science learning in a scratch-based outreach program', 'Placeholder abstract for sample data.', 'Seunguk Yu', @junlin, '/uploads/sample_paper_108.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Theoretical Computer Science on the Parameterized Complexity of Multiple-interval Graph Problems', 'Placeholder abstract for sample data.', 'Xinwei Yang', @haokun, '/uploads/sample_paper_109.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('The science in computer science', 'Placeholder abstract for sample data.', 'Yin Cai', @kristian, '/uploads/sample_paper_110.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('The roles of mathematics in computer science', 'Placeholder abstract for sample data.', 'Srishti Gureja', @srishti, '/uploads/sample_paper_111.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('The relationship between belonging and ability in computer science', 'Placeholder abstract for sample data.', 'Junlin Li', @alice, '/uploads/sample_paper_112.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Cultivating a K12 computer science community: a case study', 'Placeholder abstract for sample data.', 'Weiqi Wang', @yin, '/uploads/sample_paper_113.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Fiftieth volume of theoretical computer science', 'Placeholder abstract for sample data.', 'Zhouhong Gu', @cara, '/uploads/sample_paper_114.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('in Computer Science and Software Engineering', 'Placeholder abstract for sample data.', 'Ziyang Luo', @wenhan, '/uploads/sample_paper_115.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Indian Journal of Computer Science and Engineering', 'Placeholder abstract for sample data.', 'Ziyang Luo', @wenhan, '/uploads/sample_paper_116.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Computer Age Statistical Inference: Algorithms, Evidence, and Data Science', 'Placeholder abstract for sample data.', 'Dosung Lee', @loic, '/uploads/sample_paper_117.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('The Design and Analysis of Computer Algorithms', 'Placeholder abstract for sample data.', 'Jacy Reese Anthis', @aaron, '/uploads/sample_paper_118.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Hartree-Fock on a superconducting qubit quantum computer', 'Placeholder abstract for sample data.', 'Ermo Hua', @yin, '/uploads/sample_paper_119.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Sisvar: a computer statistical analysis system', 'Placeholder abstract for sample data.', 'Dosung Lee', @cara, '/uploads/sample_paper_120.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Beyond curriculum: the exploring computer science program', 'Placeholder abstract for sample data.', 'Jingheng Ye', @junlin, '/uploads/sample_paper_121.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Beyond access: broadening participation in high school computer science', 'Placeholder abstract for sample data.', 'Jingheng Ye', @junlin, '/uploads/sample_paper_122.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Mathematical Logic for Computer Science', 'Placeholder abstract for sample data.', 'Hongzhan Lin', @srishti, '/uploads/sample_paper_123.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Students, teachers and phenomena: educational reconstruction for computer science education', 'Placeholder abstract for sample data.', 'Hongzhan Lin', @kristian, '/uploads/sample_paper_124.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Graph Theory with Applications to Engineering and Computer Science', 'Placeholder abstract for sample data.', 'Cara Chen', @hongzhan, '/uploads/sample_paper_125.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Children learning computer science concepts via Alice game-programming', 'Placeholder abstract for sample data.', 'Jingheng Ye', @srishti, '/uploads/sample_paper_126.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('The Role of Visualization in Computer Science Education', 'Placeholder abstract for sample data.', 'Yin Cai', @jingheng, '/uploads/sample_paper_127.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Computer Science Unplugged and Related Projects in Math and Computer Science Popularization', 'Placeholder abstract for sample data.', 'Weiqi Wang', @alice, '/uploads/sample_paper_128.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Computer games created by middle school girls: Can they be used to measure understanding of computer science concepts?', 'Placeholder abstract for sample data.', 'Yin Cai', @haokun, '/uploads/sample_paper_129.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('A study of stereotype threat in computer science', 'Placeholder abstract for sample data.', 'Alice Anderson', @wenhan, '/uploads/sample_paper_130.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Design and evaluation of a braided teaching course in sixth grade computer science education', 'Placeholder abstract for sample data.', 'Junlin Li', @junlin, '/uploads/sample_paper_131.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('International Journal of Computer Science Issues', 'Placeholder abstract for sample data.', 'Haokun Liu', @jingheng, '/uploads/sample_paper_132.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Computer Security: Art and Science', 'Placeholder abstract for sample data.', 'Weiqi Wang', @kristian, '/uploads/sample_paper_133.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Science fiction in computer science education', 'Placeholder abstract for sample data.', 'Yin Cai', @srishti, '/uploads/sample_paper_134.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Analyzing Evolutionary Algorithms: The Computer Science Perspective', 'Placeholder abstract for sample data.', 'Haokun Liu', @yin, '/uploads/sample_paper_135.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('A comprehensive review of EEG-based brain–computer interface paradigms', 'Placeholder abstract for sample data.', 'Srishti Gureja', @aaron, '/uploads/sample_paper_136.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Software Engineering: A Practitioner''s Approach (McGraw-Hill Series in Computer Science)', 'Placeholder abstract for sample data.', 'Alice Anderson', @kristian, '/uploads/sample_paper_137.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('CSTA K--12 Computer Science Standards: Revised 2011', 'Placeholder abstract for sample data.', 'Jingheng Ye', @aaron, '/uploads/sample_paper_138.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Citizen Science: New Research Challenges for Human–Computer Interaction', 'Placeholder abstract for sample data.', 'Cara Chen', @yin, '/uploads/sample_paper_139.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Constructivism in computer science education', 'Placeholder abstract for sample data.', 'Bo Pan', @aaron, '/uploads/sample_paper_140.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('of Computer Science', 'Placeholder abstract for sample data.', 'Dosung Lee', @wenhan, '/uploads/sample_paper_141.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Communications in Computer and Information Science', 'Placeholder abstract for sample data.', 'Ermo Hua', @alice, '/uploads/sample_paper_142.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Exploring Computer Science: A Case Study of School Reform', 'Placeholder abstract for sample data.', 'Jingheng Ye', @xinwei, '/uploads/sample_paper_143.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('On the design of an educational infrastructure for the blind and visually impaired in computer science', 'Placeholder abstract for sample data.', 'Junlin Li', @jingheng, '/uploads/sample_paper_144.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Learning computer science concepts with scratch', 'Placeholder abstract for sample data.', 'Kristian Lum', @yin, '/uploads/sample_paper_145.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Teaching teamwork in engineering and computer science', 'Placeholder abstract for sample data.', 'Yin Cai', @seunguk, '/uploads/sample_paper_146.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Guide to Teaching Computer Science', 'Placeholder abstract for sample data.', 'Jingheng Ye', @haokun, '/uploads/sample_paper_147.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Applications of Graph Theory in Computer Science', 'Placeholder abstract for sample data.', 'Wenhan Liu', @haokun, '/uploads/sample_paper_148.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Expressing computer science concepts through Kodu game lab', 'Placeholder abstract for sample data.', 'Alice Anderson', @seunguk, '/uploads/sample_paper_149.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Guide to Teaching Computer Science: An Activity-Based Approach', 'Placeholder abstract for sample data.', 'Seunguk Yu', @zhouhong, '/uploads/sample_paper_150.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Setting the stage for computing curricula 2013: computer science -- report from the ACM/IEEE-CS joint task force', 'Placeholder abstract for sample data.', 'Ziyang Luo', @srishti, '/uploads/sample_paper_151.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Computer science/informatics in secondary education', 'Placeholder abstract for sample data.', 'Zhouhong Gu', @weiqi, '/uploads/sample_paper_152.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Fundamentals of computer graphics', 'Placeholder abstract for sample data.', 'Alice Anderson', @yin, '/uploads/sample_paper_153.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Computer Science as Empirical Inquiry', 'Placeholder abstract for sample data.', 'Wenhan Liu', @srishti, '/uploads/sample_paper_154.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Graph theory with applications to engineering and computer science', 'Placeholder abstract for sample data.', 'Haokun Liu', @weiqi, '/uploads/sample_paper_155.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('The Case for Pair Programming in the Computer Science Classroom', 'Placeholder abstract for sample data.', 'Weiqi Wang', @loic, '/uploads/sample_paper_156.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Lecture Notes in Computer Science (LNCS)', 'Placeholder abstract for sample data.', 'Kristian Lum', @hongzhan, '/uploads/sample_paper_157.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('The learning effects of computer simulations in science education', 'Placeholder abstract for sample data.', 'Wenhan Liu', @seunguk, '/uploads/sample_paper_158.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('A survey of trust in computer science and the Semantic Web', 'Placeholder abstract for sample data.', 'Cara Chen', @zhouhong, '/uploads/sample_paper_159.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Graph spectra in Computer Science', 'Placeholder abstract for sample data.', 'Junlin Li', @ziyang, '/uploads/sample_paper_160.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Exploring the role of visualization and engagement in computer science education', 'Placeholder abstract for sample data.', 'Weiqi Wang', @xinwei, '/uploads/sample_paper_161.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Library. Computer Science. Computer Science.', 'Placeholder abstract for sample data.', 'Xinwei Yang', @ermo, '/uploads/sample_paper_162.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Research Guides: Computer Science: Computer Science', 'Placeholder abstract for sample data.', 'Kristian Lum', @cara, '/uploads/sample_paper_163.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Research Guides: Computer Science: Computer Science', 'Placeholder abstract for sample data.', 'Bo Pan', @bo, '/uploads/sample_paper_164.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('A comparison of bibliometric indicators for computer science scholars and journals on Web of Science and Google Scholar', 'Placeholder abstract for sample data.', 'Jingheng Ye', @ermo, '/uploads/sample_paper_165.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('APPLICATIONS OF GRAPH THEORY IN COMPUTER SCIENCE AN OVERVIEW', 'Placeholder abstract for sample data.', 'Haokun Liu', @cara, '/uploads/sample_paper_166.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('International Journal of Computer Vision', 'Placeholder abstract for sample data.', 'Bo Pan', @jacy, '/uploads/sample_paper_167.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Teaching computer science in context', 'Placeholder abstract for sample data.', 'Wenhan Liu', @xinwei, '/uploads/sample_paper_168.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Teaching computer science through problems, not solutions', 'Placeholder abstract for sample data.', 'Srishti Gureja', @hongzhan, '/uploads/sample_paper_169.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Collaboration in computer science: A network science approach', 'Placeholder abstract for sample data.', 'Wenhan Liu', @aaron, '/uploads/sample_paper_170.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Computer science teacher preparation is critical', 'Placeholder abstract for sample data.', 'Wenhan Liu', @loic, '/uploads/sample_paper_171.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Thinking Machines and the Philosophy of Computer Science: Concepts and Principles', 'Placeholder abstract for sample data.', 'Cara Chen', @alice, '/uploads/sample_paper_172.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Gender differences in the use of computers, programming, and peer interactions in computer science classrooms', 'Placeholder abstract for sample data.', 'Srishti Gureja', @weiqi, '/uploads/sample_paper_173.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Using scalable game design to teach computer science from middle school to graduate school', 'Placeholder abstract for sample data.', 'Jacy Reese Anthis', @yin, '/uploads/sample_paper_174.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('ICT4D: A Computer Science Perspective', 'Placeholder abstract for sample data.', 'Junlin Li', @bo, '/uploads/sample_paper_175.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Handbook of logic in computer science.', 'Placeholder abstract for sample data.', 'Jingheng Ye', @loic, '/uploads/sample_paper_176.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Guides: Websites - Computer Science: Computer Science', 'Placeholder abstract for sample data.', 'Loic Fosse', @hongzhan, '/uploads/sample_paper_177.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Running on Empty: the Failure to Teach K--12 Computer Science in the Digital Age', 'Placeholder abstract for sample data.', 'Srishti Gureja', @xinwei, '/uploads/sample_paper_178.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('DEPARTMENT OF COMPUTER SCIENCE AND ENGINEERING', 'Placeholder abstract for sample data.', 'Jacy Reese Anthis', @ermo, '/uploads/sample_paper_179.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Logic in computer science - modelling and reasoning about systems', 'Placeholder abstract for sample data.', 'Ziyang Luo', @weiqi, '/uploads/sample_paper_180.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Computer science unplugged: school students doing real computing without computers', 'Placeholder abstract for sample data.', 'Ermo Hua', @cara, '/uploads/sample_paper_181.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Algorithms on Strings, Trees, and Sequences: Computer Science and Computational Biology', 'Placeholder abstract for sample data.', 'Jingheng Ye', @yin, '/uploads/sample_paper_182.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Validity of the computer science and applications (CSA) activity monitor in children.', 'Placeholder abstract for sample data.', 'Jacy Reese Anthis', @jingheng, '/uploads/sample_paper_183.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Department of Computer Science and Engineering', 'Placeholder abstract for sample data.', 'Ziyang Luo', @yin, '/uploads/sample_paper_184.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Foundations of Data Science', 'Placeholder abstract for sample data.', 'Jingheng Ye', @junlin, '/uploads/sample_paper_185.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('What Is Computer Science?', 'Placeholder abstract for sample data.', 'Ermo Hua', @dosung, '/uploads/sample_paper_186.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Quantum Algorithms for Quantum Chemistry and Quantum Materials Science.', 'Placeholder abstract for sample data.', 'Dosung Lee', @junlin, '/uploads/sample_paper_187.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Exploring factors that influence computer science introductory course students to persist in the major', 'Placeholder abstract for sample data.', 'Seunguk Yu', @kristian, '/uploads/sample_paper_188.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('LibGuides. Computer Science. Computer Science.', 'Placeholder abstract for sample data.', 'Yin Cai', @seunguk, '/uploads/sample_paper_189.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('ViewpointResearch evaluation for computer science', 'Placeholder abstract for sample data.', 'Yin Cai', @dosung, '/uploads/sample_paper_190.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('ViewpointTime for computer science to grow up', 'Placeholder abstract for sample data.', 'Jingheng Ye', @hongzhan, '/uploads/sample_paper_191.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Methods, metrics and motivation for a green computer science program', 'Placeholder abstract for sample data.', 'Haokun Liu', @jacy, '/uploads/sample_paper_192.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Bridging ICT and CS: educational standards for computer science in lower secondary education', 'Placeholder abstract for sample data.', 'Junlin Li', @junlin, '/uploads/sample_paper_193.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Computer science outreach in an elementary school', 'Placeholder abstract for sample data.', 'Bo Pan', @alice, '/uploads/sample_paper_194.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Examining science and engineering students'' attitudes toward computer science', 'Placeholder abstract for sample data.', 'Bo Pan', @hongzhan, '/uploads/sample_paper_195.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Computer Science Unplugged', 'Placeholder abstract for sample data.', 'Seunguk Yu', @bo, '/uploads/sample_paper_196.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Preparation of Papers for the IAENG International Journal of Computer Science', 'Placeholder abstract for sample data.', 'Bo Pan', @loic, '/uploads/sample_paper_197.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Handbook of Theoretical Computer Science, Volume B: Formal Models and Semantics', 'Placeholder abstract for sample data.', 'Cara Chen', @dosung, '/uploads/sample_paper_198.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Epistemic logic for AI and computer science', 'Placeholder abstract for sample data.', 'Kristian Lum', @dosung, '/uploads/sample_paper_199.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Student perceptions of computer science: a retention study comparing graduating seniors with cs leavers', 'Placeholder abstract for sample data.', 'Dosung Lee', @kristian, '/uploads/sample_paper_200.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Student perceptions of computer science: a retention study comparing graduating seniors with cs leavers', 'Placeholder abstract for sample data.', 'Jingheng Ye', @ermo, '/uploads/sample_paper_201.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Modern computer algebra', 'Placeholder abstract for sample data.', 'Junlin Li', @kristian, '/uploads/sample_paper_202.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('A Methodological Review of Computer Science Education Research', 'Placeholder abstract for sample data.', 'Kristian Lum', @junlin, '/uploads/sample_paper_203.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('LibGuides: Computer Science: Computer Science', 'Placeholder abstract for sample data.', 'Dosung Lee', @ziyang, '/uploads/sample_paper_204.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Enhancing learning management systems to better support computer science education', 'Placeholder abstract for sample data.', 'Jingheng Ye', @srishti, '/uploads/sample_paper_205.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('A model for high school computer science education: the four key elements that make it!', 'Placeholder abstract for sample data.', 'Hongzhan Lin', @jacy, '/uploads/sample_paper_206.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Inspiring blind high school students to pursue computer science with instant messaging chatbots', 'Placeholder abstract for sample data.', 'Loic Fosse', @seunguk, '/uploads/sample_paper_207.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Dangers of a fixed mindset: implications of self-theories research for computer science education', 'Placeholder abstract for sample data.', 'Xinwei Yang', @cara, '/uploads/sample_paper_208.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('CS 0.5: a better approach to introductory computer science for majors', 'Placeholder abstract for sample data.', 'Yin Cai', @aaron, '/uploads/sample_paper_209.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Quantum Computer Science', 'Placeholder abstract for sample data.', 'Yin Cai', @dosung, '/uploads/sample_paper_210.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Bloom''s taxonomy revisited: specifying assessable learning objectives in computer science', 'Placeholder abstract for sample data.', 'Loic Fosse', @ermo, '/uploads/sample_paper_211.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Creativity as a pathway to computer science', 'Placeholder abstract for sample data.', 'Dosung Lee', @aaron, '/uploads/sample_paper_212.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Increasing diversity in k-12 computer science: strategies from the field', 'Placeholder abstract for sample data.', 'Weiqi Wang', @dosung, '/uploads/sample_paper_213.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Wiley Encyclopedia of Computer Science and Engineering', 'Placeholder abstract for sample data.', 'Xinwei Yang', @xinwei, '/uploads/sample_paper_214.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('The DBLP Computer Science Bibliography: Evolution, Research Issues, Perspectives', 'Placeholder abstract for sample data.', 'Junlin Li', @alice, '/uploads/sample_paper_215.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Engaging with computer science through magic shows', 'Placeholder abstract for sample data.', 'Ziyang Luo', @dosung, '/uploads/sample_paper_216.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Computer Science unplugged', 'Placeholder abstract for sample data.', 'Jacy Reese Anthis', @junlin, '/uploads/sample_paper_217.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Why students with an apparent aptitude for computer science don''t choose to major in computer science', 'Placeholder abstract for sample data.', 'Hongzhan Lin', @loic, '/uploads/sample_paper_218.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Research Methods for Human-Computer Interaction', 'Placeholder abstract for sample data.', 'Ziyang Luo', @junlin, '/uploads/sample_paper_219.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Logic in Computer Science: Modelling and Reasoning about Systems', 'Placeholder abstract for sample data.', 'Junlin Li', @hongzhan, '/uploads/sample_paper_220.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Quantum Computer Science: An Introduction', 'Placeholder abstract for sample data.', 'Haokun Liu', @loic, '/uploads/sample_paper_221.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('DEPARTMENT OF COMPUTER SCIENCE AND INFORMATION ENGINEERING', 'Placeholder abstract for sample data.', 'Junlin Li', @wenhan, '/uploads/sample_paper_222.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Contributing to success in an introductory computer science course: a study of twelve factors', 'Placeholder abstract for sample data.', 'Alice Anderson', @jacy, '/uploads/sample_paper_223.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Computer Science Curriculum 2008: An Interim Revision of CS 2001', 'Placeholder abstract for sample data.', 'Jingheng Ye', @dosung, '/uploads/sample_paper_224.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Handbook of Theoretical Computer Science, Vol. B: Formal Models and Semantics', 'Placeholder abstract for sample data.', 'Haokun Liu', @bo, '/uploads/sample_paper_225.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Why the high attrition rate for computer science students: some thoughts and observations', 'Placeholder abstract for sample data.', 'Srishti Gureja', @wenhan, '/uploads/sample_paper_226.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Making a Science of Model Search: Hyperparameter Optimization in Hundreds of Dimensions for Vision Architectures', 'Placeholder abstract for sample data.', 'Aaron Nicolson', @junlin, '/uploads/sample_paper_227.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Quantum Computer Systems for Scientific Discovery', 'Placeholder abstract for sample data.', 'Jingheng Ye', @jacy, '/uploads/sample_paper_228.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Growing Artificial Societies: Social Science from the Bottom Up', 'Placeholder abstract for sample data.', 'Ermo Hua', @wenhan, '/uploads/sample_paper_229.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Concrete Mathematics, a Foundation for Computer Science', 'Placeholder abstract for sample data.', 'Kristian Lum', @loic, '/uploads/sample_paper_230.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Metaphor in computer science', 'Placeholder abstract for sample data.', 'Junlin Li', @xinwei, '/uploads/sample_paper_231.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Computer science and game theory', 'Placeholder abstract for sample data.', 'Wenhan Liu', @ziyang, '/uploads/sample_paper_232.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Extremal Combinatorics: With Applications in Computer Science', 'Placeholder abstract for sample data.', 'Cara Chen', @wenhan, '/uploads/sample_paper_233.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Developing a computer science-specific learning taxonomy', 'Placeholder abstract for sample data.', 'Alice Anderson', @haokun, '/uploads/sample_paper_234.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Foundations of Computer Science', 'Placeholder abstract for sample data.', 'Srishti Gureja', @aaron, '/uploads/sample_paper_235.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Attitudes towards computer science-computing experiences as a starting point and barrier to computer science', 'Placeholder abstract for sample data.', 'Hongzhan Lin', @cara, '/uploads/sample_paper_236.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Gender differences in computer science students', 'Placeholder abstract for sample data.', 'Haokun Liu', @jacy, '/uploads/sample_paper_237.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Validity of the Computer Science and Applications, Inc. (CSA) activity monitor.', 'Placeholder abstract for sample data.', 'Aaron Nicolson', @jacy, '/uploads/sample_paper_238.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('LibGuides: Computer Science: Computer Science Databases', 'Placeholder abstract for sample data.', 'Bo Pan', @srishti, '/uploads/sample_paper_239.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('LibGuides: Computer Science: Computer Science Books', 'Placeholder abstract for sample data.', 'Yin Cai', @loic, '/uploads/sample_paper_240.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('LibGuides: Computer Science: Computer Science', 'Placeholder abstract for sample data.', 'Ermo Hua', @haokun, '/uploads/sample_paper_241.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Handbook of Theoretical Computer Science, Volume B: Formal Models and Semantics', 'Placeholder abstract for sample data.', 'Kristian Lum', @aaron, '/uploads/sample_paper_242.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Probability and Statistics With Reliability, Queuing and Computer Science Applications', 'Placeholder abstract for sample data.', 'Haokun Liu', @aaron, '/uploads/sample_paper_243.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('A Study of Factors Promoting Success in Computer Science Including Gender Differences', 'Placeholder abstract for sample data.', 'Ziyang Luo', @cara, '/uploads/sample_paper_244.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Algorithmic Thinking: The Key for Understanding Computer Science', 'Placeholder abstract for sample data.', 'Wenhan Liu', @kristian, '/uploads/sample_paper_245.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Encyclopedia of Computer Science and Technology', 'Placeholder abstract for sample data.', 'Ziyang Luo', @ziyang, '/uploads/sample_paper_246.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Fundamentals of Algebraic Graph Transformation (Monographs in Theoretical Computer Science. An EATCS Series)', 'Placeholder abstract for sample data.', 'Seunguk Yu', @ziyang, '/uploads/sample_paper_247.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Is computer science science?', 'Placeholder abstract for sample data.', 'Jingheng Ye', @dosung, '/uploads/sample_paper_248.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('An analysis of patterns of debugging among novice computer science students', 'Placeholder abstract for sample data.', 'Srishti Gureja', @ermo, '/uploads/sample_paper_249.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Designing computer learning environments for engineering and computer science: The scaffolded knowledge integration framework', 'Placeholder abstract for sample data.', 'Junlin Li', @jacy, '/uploads/sample_paper_250.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Experiences with a tablet PC based lecture presentation system in computer science courses', 'Placeholder abstract for sample data.', 'Loic Fosse', @ermo, '/uploads/sample_paper_251.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Toward improving female retention in the computer science major', 'Placeholder abstract for sample data.', 'Weiqi Wang', @bo, '/uploads/sample_paper_252.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('The Computer Science and Engineering Handbook', 'Placeholder abstract for sample data.', 'Junlin Li', @seunguk, '/uploads/sample_paper_253.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Pair-programming helps female computer science students', 'Placeholder abstract for sample data.', 'Loic Fosse', @hongzhan, '/uploads/sample_paper_254.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Lotka''s Law and Computer Science Literature', 'Placeholder abstract for sample data.', 'Xinwei Yang', @haokun, '/uploads/sample_paper_255.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('A comparison of the methodological quality of articles in computer science education journals and conference proceedings', 'Placeholder abstract for sample data.', 'Loic Fosse', @seunguk, '/uploads/sample_paper_256.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Opening the door of the computer science classroom: the disciplinary commons', 'Placeholder abstract for sample data.', 'Ermo Hua', @bo, '/uploads/sample_paper_257.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Web science: a provocative invitation to computer science', 'Placeholder abstract for sample data.', 'Cara Chen', @haokun, '/uploads/sample_paper_258.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Podcasting computer science E-1', 'Placeholder abstract for sample data.', 'Yin Cai', @srishti, '/uploads/sample_paper_259.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Abstraction in Computer Science', 'Placeholder abstract for sample data.', 'Wenhan Liu', @yin, '/uploads/sample_paper_260.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Three Paradigms of Computer Science', 'Placeholder abstract for sample data.', 'Jacy Reese Anthis', @hongzhan, '/uploads/sample_paper_261.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Threshold concepts in computer science: do they exist and are they useful?', 'Placeholder abstract for sample data.', 'Seunguk Yu', @cara, '/uploads/sample_paper_262.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Curriculum ''78: recommendations for the undergraduate program in computer science— a report of the ACM curriculum committee on computer science', 'Placeholder abstract for sample data.', 'Jingheng Ye', @jacy, '/uploads/sample_paper_263.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Brownian Functionals in Physics and Computer Science', 'Placeholder abstract for sample data.', 'Wenhan Liu', @dosung, '/uploads/sample_paper_264.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Motivation and nonmajors in computer science: identifying discrete audiences for introductory courses', 'Placeholder abstract for sample data.', 'Srishti Gureja', @cara, '/uploads/sample_paper_265.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Concrete mathematics - a foundation for computer science (2. ed.)', 'Placeholder abstract for sample data.', 'Aaron Nicolson', @ziyang, '/uploads/sample_paper_266.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Using interdisciplinary bioinformatics undergraduate research to recruit and retain computer science students', 'Placeholder abstract for sample data.', 'Alice Anderson', @alice, '/uploads/sample_paper_267.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Problem-Based Learning for Foundation Computer Science Courses', 'Placeholder abstract for sample data.', 'Srishti Gureja', @wenhan, '/uploads/sample_paper_268.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('In: Handbook of Logic in Computer Science', 'Placeholder abstract for sample data.', 'Alice Anderson', @aaron, '/uploads/sample_paper_269.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('School of computer science', 'Placeholder abstract for sample data.', 'Yin Cai', @junlin, '/uploads/sample_paper_270.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Qualitative research in computer science education', 'Placeholder abstract for sample data.', 'Junlin Li', @ermo, '/uploads/sample_paper_271.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Making computer science minority-friendly', 'Placeholder abstract for sample data.', 'Jingheng Ye', @yin, '/uploads/sample_paper_272.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('"Python first": a lab-based digital introduction to computer science', 'Placeholder abstract for sample data.', 'Zhouhong Gu', @xinwei, '/uploads/sample_paper_273.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Gender, achievement, and persistence in an undergraduate computer science program', 'Placeholder abstract for sample data.', 'Dosung Lee', @yin, '/uploads/sample_paper_274.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('EduComponents: experiences in e-assessment in computer science education', 'Placeholder abstract for sample data.', 'Jingheng Ye', @ermo, '/uploads/sample_paper_275.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Bridging writing to learn and writing in the discipline in computer science education', 'Placeholder abstract for sample data.', 'Srishti Gureja', @seunguk, '/uploads/sample_paper_276.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('On teaching computer ethics within a computer science department', 'Placeholder abstract for sample data.', 'Seunguk Yu', @ziyang, '/uploads/sample_paper_277.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Putting threshold concepts into context in computer science education', 'Placeholder abstract for sample data.', 'Zhouhong Gu', @dosung, '/uploads/sample_paper_278.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('A High School Program in Computer Science', 'Placeholder abstract for sample data.', 'Loic Fosse', @jacy, '/uploads/sample_paper_279.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Curriculum 68: Recommendations for academic programs in computer science: a report of the ACM curriculum committee on computer science', 'Placeholder abstract for sample data.', 'Haokun Liu', @alice, '/uploads/sample_paper_280.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Computer anxiety, self-efficacy, computer experience: an investigation throughout a computer science degree', 'Placeholder abstract for sample data.', 'Wenhan Liu', @bo, '/uploads/sample_paper_281.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('A computer attitude scale for computer science freshmen and its educational implications', 'Placeholder abstract for sample data.', 'Weiqi Wang', @srishti, '/uploads/sample_paper_282.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Philosophy of Computer Science: An Introductory Course', 'Placeholder abstract for sample data.', 'Alice Anderson', @ermo, '/uploads/sample_paper_283.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Recentering computer science', 'Placeholder abstract for sample data.', 'Ermo Hua', @loic, '/uploads/sample_paper_284.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('The dream of a common language: the search for simplicity and stability in computer science education', 'Placeholder abstract for sample data.', 'Aaron Nicolson', @junlin, '/uploads/sample_paper_285.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Why women avoid computer science', 'Placeholder abstract for sample data.', 'Srishti Gureja', @weiqi, '/uploads/sample_paper_286.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('CS girls rock: sparking interest in computer science and debunking the stereotypes', 'Placeholder abstract for sample data.', 'Ziyang Luo', @wenhan, '/uploads/sample_paper_287.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Strategic directions in computer science education', 'Placeholder abstract for sample data.', 'Hongzhan Lin', @cara, '/uploads/sample_paper_288.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Benefits of using socially-relevant projects in computer science and engineering education', 'Placeholder abstract for sample data.', 'Xinwei Yang', @ermo, '/uploads/sample_paper_289.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Encyclopedia of Computer Science', 'Placeholder abstract for sample data.', 'Jingheng Ye', @weiqi, '/uploads/sample_paper_290.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Software engineering programmes are not computer science programmes', 'Placeholder abstract for sample data.', 'Ziyang Luo', @haokun, '/uploads/sample_paper_291.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('An Analysis of Retention Problems for Female Students in University Computer Science Programs', 'Placeholder abstract for sample data.', 'Ermo Hua', @alice, '/uploads/sample_paper_292.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Geometric Fundamentals of Robotics (Monographs in Computer Science)', 'Placeholder abstract for sample data.', 'Wenhan Liu', @xinwei, '/uploads/sample_paper_293.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Office Information Systems and Computer Science', 'Placeholder abstract for sample data.', 'Wenhan Liu', @loic, '/uploads/sample_paper_294.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Learning Computer Science and Engineering in Context', 'Placeholder abstract for sample data.', 'Dosung Lee', @yin, '/uploads/sample_paper_295.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Electronic peer review and peer grading in computer-science courses', 'Placeholder abstract for sample data.', 'Dosung Lee', @yin, '/uploads/sample_paper_296.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Predicting student performance in a beginning computer science class', 'Placeholder abstract for sample data.', 'Alice Anderson', @loic, '/uploads/sample_paper_297.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Situated Learning in Computer Science Education', 'Placeholder abstract for sample data.', 'Ermo Hua', @jacy, '/uploads/sample_paper_298.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Predicting performance in an introductory computer science course', 'Placeholder abstract for sample data.', 'Ziyang Luo', @ermo, '/uploads/sample_paper_299.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Computer Science Illuminated', 'Placeholder abstract for sample data.', 'Ermo Hua', @srishti, '/uploads/sample_paper_300.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Some computer science issues in ubiquitous computing', 'Placeholder abstract for sample data.', 'Loic Fosse', @weiqi, '/uploads/sample_paper_301.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Design and implementation of computer games: a capstone course for undergraduate computer science education', 'Placeholder abstract for sample data.', 'Kristian Lum', @hongzhan, '/uploads/sample_paper_302.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Motivation and Academic Help-Seeking in High School Computer Science', 'Placeholder abstract for sample data.', 'Ziyang Luo', @bo, '/uploads/sample_paper_303.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Applications of deontic logic in computer science: a concise overview', 'Placeholder abstract for sample data.', 'Alice Anderson', @wenhan, '/uploads/sample_paper_304.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Bloom''s taxonomy applied to testing in computer science classes', 'Placeholder abstract for sample data.', 'Jacy Reese Anthis', @junlin, '/uploads/sample_paper_305.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Programming patterns and design patterns in the introductory computer science course', 'Placeholder abstract for sample data.', 'Jacy Reese Anthis', @seunguk, '/uploads/sample_paper_306.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Benefits of using socially-relevant projects in computer science and engineering education', 'Placeholder abstract for sample data.', 'Yin Cai', @srishti, '/uploads/sample_paper_307.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Field evaluation of the Computer Science and Applications, Inc. physical activity monitor.', 'Placeholder abstract for sample data.', 'Xinwei Yang', @ermo, '/uploads/sample_paper_308.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Using pen-based computers across the computer science curriculum', 'Placeholder abstract for sample data.', 'Cara Chen', @alice, '/uploads/sample_paper_309.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Topology and category theory in computer science', 'Placeholder abstract for sample data.', 'Srishti Gureja', @seunguk, '/uploads/sample_paper_310.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Combining cooperative learning and peer instruction in introductory computer science', 'Placeholder abstract for sample data.', 'Zhouhong Gu', @cara, '/uploads/sample_paper_311.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Pioneering women in computer science', 'Placeholder abstract for sample data.', 'Dosung Lee', @weiqi, '/uploads/sample_paper_312.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Encouraging women in computer science', 'Placeholder abstract for sample data.', 'Ermo Hua', @srishti, '/uploads/sample_paper_313.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Student culture vs group work in computer science', 'Placeholder abstract for sample data.', 'Bo Pan', @jacy, '/uploads/sample_paper_314.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Defensive climate in the computer science classroom', 'Placeholder abstract for sample data.', 'Dosung Lee', @jingheng, '/uploads/sample_paper_315.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('The Anatomy of Interest: Women in Undergraduate Computer Science', 'Placeholder abstract for sample data.', 'Wenhan Liu', @jacy, '/uploads/sample_paper_316.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('How Students Attempt to Reduce Abstraction in the Learning of Mathematics and in the Learning of Computer Science', 'Placeholder abstract for sample data.', 'Ermo Hua', @loic, '/uploads/sample_paper_317.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Software Engineering Programs Are Not Computer Science Programs', 'Placeholder abstract for sample data.', 'Zhouhong Gu', @loic, '/uploads/sample_paper_318.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Undergraduate women in computer science: experience, motivation and culture', 'Placeholder abstract for sample data.', 'Cara Chen', @yin, '/uploads/sample_paper_319.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Measuring the effectiveness of robots in teaching computer science', 'Placeholder abstract for sample data.', 'Srishti Gureja', @aaron, '/uploads/sample_paper_320.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('An Analysis of Retention Problems for Female Students in University Computer Science Programs', 'Placeholder abstract for sample data.', 'Jingheng Ye', @srishti, '/uploads/sample_paper_321.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Strategic directions in computer science education', 'Placeholder abstract for sample data.', 'Hongzhan Lin', @jacy, '/uploads/sample_paper_322.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Scientific Methods in Computer Science', 'Placeholder abstract for sample data.', 'Cara Chen', @haokun, '/uploads/sample_paper_323.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Predicting the success of freshmen in a computer science major', 'Placeholder abstract for sample data.', 'Ermo Hua', @zhouhong, '/uploads/sample_paper_324.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Teaching objects-first in introductory computer science', 'Placeholder abstract for sample data.', 'Loic Fosse', @jacy, '/uploads/sample_paper_325.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('COMPUTER SCIENCE: THE DISCIPLINE', 'Placeholder abstract for sample data.', 'Jacy Reese Anthis', @haokun, '/uploads/sample_paper_326.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Still a stranger here: attitudes among secondary school students towards computer science', 'Placeholder abstract for sample data.', 'Wenhan Liu', @dosung, '/uploads/sample_paper_327.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Python Programming : An Introduction to Computer Science', 'Placeholder abstract for sample data.', 'Seunguk Yu', @jingheng, '/uploads/sample_paper_328.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Geometric Fundamentals of Robotics (Monographs in Computer Science)', 'Placeholder abstract for sample data.', 'Xinwei Yang', @kristian, '/uploads/sample_paper_329.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Learning Computer Science and Engineering in Context', 'Placeholder abstract for sample data.', 'Jingheng Ye', @yin, '/uploads/sample_paper_330.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Software engineering programmes are not computer science programmes', 'Placeholder abstract for sample data.', 'Xinwei Yang', @loic, '/uploads/sample_paper_331.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Mathematical Foundations of Computer Science 2003', 'Placeholder abstract for sample data.', 'Seunguk Yu', @kristian, '/uploads/sample_paper_332.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Electronic peer review and peer grading in computer-science courses', 'Placeholder abstract for sample data.', 'Kristian Lum', @zhouhong, '/uploads/sample_paper_333.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Discrete Mathematical Structures with Applications to Computer Science', 'Placeholder abstract for sample data.', 'Jingheng Ye', @bo, '/uploads/sample_paper_334.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('CS girls rock: sparking interest in computer science and debunking the stereotypes', 'Placeholder abstract for sample data.', 'Ermo Hua', @haokun, '/uploads/sample_paper_335.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Situated Learning in Computer Science Education', 'Placeholder abstract for sample data.', 'Xinwei Yang', @ermo, '/uploads/sample_paper_336.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Experimenting with Industry''s "Pair-Programming" Model in the Computer Science Classroom', 'Placeholder abstract for sample data.', 'Alice Anderson', @kristian, '/uploads/sample_paper_337.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Computer Science Illuminated', 'Placeholder abstract for sample data.', 'Loic Fosse', @loic, '/uploads/sample_paper_338.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Predicting student performance in a beginning computer science class', 'Placeholder abstract for sample data.', 'Junlin Li', @xinwei, '/uploads/sample_paper_339.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('A model curriculum for a liberal arts degree in computer science', 'Placeholder abstract for sample data.', 'Hongzhan Lin', @ermo, '/uploads/sample_paper_340.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Computer Science Attitude Survey', 'Placeholder abstract for sample data.', 'Kristian Lum', @hongzhan, '/uploads/sample_paper_341.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('A revised model curriculum for a liberal arts degree in computer science', 'Placeholder abstract for sample data.', 'Jacy Reese Anthis', @seunguk, '/uploads/sample_paper_342.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Computer science in Japanese universities', 'Placeholder abstract for sample data.', 'Jacy Reese Anthis', @haokun, '/uploads/sample_paper_343.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('A citation study of computer science literature', 'Placeholder abstract for sample data.', 'Wenhan Liu', @jacy, '/uploads/sample_paper_344.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('A concepts-first introduction to computer science', 'Placeholder abstract for sample data.', 'Aaron Nicolson', @aaron, '/uploads/sample_paper_345.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('An interactive lecture approach to teaching computer science', 'Placeholder abstract for sample data.', 'Weiqi Wang', @haokun, '/uploads/sample_paper_346.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Integrating Computer Ethics into the Computer Science Curriculum', 'Placeholder abstract for sample data.', 'Seunguk Yu', @loic, '/uploads/sample_paper_347.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Developing oral communication skills of computer science undergraduates', 'Placeholder abstract for sample data.', 'Loic Fosse', @srishti, '/uploads/sample_paper_348.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Research paradigms in computer science', 'Placeholder abstract for sample data.', 'Jacy Reese Anthis', @seunguk, '/uploads/sample_paper_349.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Factors Influencing Success in Beginning Computer Science Courses.', 'Placeholder abstract for sample data.', 'Kristian Lum', @yin, '/uploads/sample_paper_350.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Computer Science Education in the 21st Century', 'Placeholder abstract for sample data.', 'Ermo Hua', @jingheng, '/uploads/sample_paper_351.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Computing as a discipline: preliminary report of the ACM task force on the core of computer science', 'Placeholder abstract for sample data.', 'Alice Anderson', @ermo, '/uploads/sample_paper_352.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Algorithm visualization in computer science laboratories', 'Placeholder abstract for sample data.', 'Cara Chen', @jingheng, '/uploads/sample_paper_353.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('One Man''s View of Computer Science', 'Placeholder abstract for sample data.', 'Jingheng Ye', @alice, '/uploads/sample_paper_354.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('A primer for applying service learning to computer science', 'Placeholder abstract for sample data.', 'Zhouhong Gu', @kristian, '/uploads/sample_paper_355.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Algorithms in Modern Mathematics and Computer Science', 'Placeholder abstract for sample data.', 'Seunguk Yu', @yin, '/uploads/sample_paper_356.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Form and Content in Computer Science', 'Placeholder abstract for sample data.', 'Haokun Liu', @zhouhong, '/uploads/sample_paper_357.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Logic for Computer Science: Foundations of Automatic Theorem Proving', 'Placeholder abstract for sample data.', 'Aaron Nicolson', @jacy, '/uploads/sample_paper_358.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Challenges to computer science education research', 'Placeholder abstract for sample data.', 'Zhouhong Gu', @ziyang, '/uploads/sample_paper_359.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Computer Science Today: Recent Trends and Developments', 'Placeholder abstract for sample data.', 'Weiqi Wang', @yin, '/uploads/sample_paper_360.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('What Does the Future Hold for Theoretical Computer Science?', 'Placeholder abstract for sample data.', 'Junlin Li', @jacy, '/uploads/sample_paper_361.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Envision: a user-centered database of computer science literature', 'Placeholder abstract for sample data.', 'Dosung Lee', @dosung, '/uploads/sample_paper_362.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Computer Science Program Requirements and Accreditation', 'Placeholder abstract for sample data.', 'Zhouhong Gu', @srishti, '/uploads/sample_paper_363.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Formalism in AI and computer science', 'Placeholder abstract for sample data.', 'Alice Anderson', @cara, '/uploads/sample_paper_364.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('A university''s educational program in computer science', 'Placeholder abstract for sample data.', 'Loic Fosse', @alice, '/uploads/sample_paper_365.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Computation and reasoning - a type theory for computer science', 'Placeholder abstract for sample data.', 'Seunguk Yu', @bo, '/uploads/sample_paper_366.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Computer Simulations to Support Science Instruction and Learning: A critical review of the literature', 'Placeholder abstract for sample data.', 'Haokun Liu', @wenhan, '/uploads/sample_paper_367.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Integrating writing into computer science courses', 'Placeholder abstract for sample data.', 'Alice Anderson', @wenhan, '/uploads/sample_paper_368.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Discrete mathematics in computer science', 'Placeholder abstract for sample data.', 'Aaron Nicolson', @xinwei, '/uploads/sample_paper_369.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Introduction to computer science: A structured approach', 'Placeholder abstract for sample data.', 'Srishti Gureja', @yin, '/uploads/sample_paper_370.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Integrating technology into computer science examinations', 'Placeholder abstract for sample data.', 'Loic Fosse', @zhouhong, '/uploads/sample_paper_371.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Computer Science And Statistics', 'Placeholder abstract for sample data.', 'Seunguk Yu', @seunguk, '/uploads/sample_paper_372.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Laboratories in the Computer Science Curriculum', 'Placeholder abstract for sample data.', 'Jingheng Ye', @cara, '/uploads/sample_paper_373.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Department of Computer Science', 'Placeholder abstract for sample data.', 'Srishti Gureja', @jacy, '/uploads/sample_paper_374.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Computers and Classroom Culture: Computer Science 1: The Classroom and the Lab as Contrasting Learning Environments', 'Placeholder abstract for sample data.', 'Xinwei Yang', @hongzhan, '/uploads/sample_paper_375.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('In handbook of theoretical computer science', 'Placeholder abstract for sample data.', 'Alice Anderson', @bo, '/uploads/sample_paper_376.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Probability and Statistics with Reliability, Queueing and Computer Science Applications', 'Placeholder abstract for sample data.', 'Aaron Nicolson', @jingheng, '/uploads/sample_paper_377.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Some Computer Science Problems in Ubiquitous Computing', 'Placeholder abstract for sample data.', 'Ziyang Luo', @haokun, '/uploads/sample_paper_378.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Agent Based Social Simulation: A Computer Science View', 'Placeholder abstract for sample data.', 'Dosung Lee', @hongzhan, '/uploads/sample_paper_379.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('The Art of Computer Programming, 2nd Ed. (Addison-Wesley Series in Computer Science and Information', 'Placeholder abstract for sample data.', 'Srishti Gureja', @haokun, '/uploads/sample_paper_380.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Graph-Theoretic Concepts in Computer Science', 'Placeholder abstract for sample data.', 'Haokun Liu', @loic, '/uploads/sample_paper_381.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('The Schematic Structure of Computer Science Research Articles', 'Placeholder abstract for sample data.', 'Xinwei Yang', @dosung, '/uploads/sample_paper_382.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Semirings: Algebraic Theory and Applications in Computer Science', 'Placeholder abstract for sample data.', 'Alice Anderson', @bo, '/uploads/sample_paper_383.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Identifying and correcting Java programming errors for introductory computer science students', 'Placeholder abstract for sample data.', 'Kristian Lum', @loic, '/uploads/sample_paper_384.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Department of Mathematics and Computer Science', 'Placeholder abstract for sample data.', 'Weiqi Wang', @kristian, '/uploads/sample_paper_385.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Geometric Methods and Applications: For Computer Science and Engineering', 'Placeholder abstract for sample data.', 'Wenhan Liu', @wenhan, '/uploads/sample_paper_386.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Case studies for self-organization in computer science', 'Placeholder abstract for sample data.', 'Seunguk Yu', @aaron, '/uploads/sample_paper_387.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Graph-Theoretic Concepts in Computer Science', 'Placeholder abstract for sample data.', 'Haokun Liu', @zhouhong, '/uploads/sample_paper_388.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Graph-Theoretic Concepts in Computer Science', 'Placeholder abstract for sample data.', 'Junlin Li', @alice, '/uploads/sample_paper_389.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Randomization and Approximation Techniques in Computer Science', 'Placeholder abstract for sample data.', 'Ziyang Luo', @hongzhan, '/uploads/sample_paper_390.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Real-time computing: a new discipline of computer science and engineering', 'Placeholder abstract for sample data.', 'Junlin Li', @loic, '/uploads/sample_paper_391.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Logic in Computer Science', 'Placeholder abstract for sample data.', 'Kristian Lum', @bo, '/uploads/sample_paper_392.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Deontic logic in computer science: normative system specification', 'Placeholder abstract for sample data.', 'Zhouhong Gu', @dosung, '/uploads/sample_paper_393.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Experimental evaluation in computer science: A quantitative study', 'Placeholder abstract for sample data.', 'Dosung Lee', @junlin, '/uploads/sample_paper_394.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('The theory of semirings with applications in mathematics and theoretical computer science', 'Placeholder abstract for sample data.', 'Bo Pan', @kristian, '/uploads/sample_paper_395.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('In Support of Pair Programming in the Introductory Computer Science Course', 'Placeholder abstract for sample data.', 'Yin Cai', @yin, '/uploads/sample_paper_396.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Computing Curricula 2001: Computer Science', 'Placeholder abstract for sample data.', 'Zhouhong Gu', @jacy, '/uploads/sample_paper_397.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Discrete Mathematics and Theoretical Computer Science', 'Placeholder abstract for sample data.', 'Xinwei Yang', @zhouhong, '/uploads/sample_paper_398.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Lost in Translation: Gender and High School Computer Science', 'Placeholder abstract for sample data.', 'Loic Fosse', @bo, '/uploads/sample_paper_399.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Things are clicking in computer science courses', 'Placeholder abstract for sample data.', 'Seunguk Yu', @aaron, '/uploads/sample_paper_400.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Microelectronics and Computer Science', 'Placeholder abstract for sample data.', 'Zhouhong Gu', @hongzhan, '/uploads/sample_paper_401.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('The development of multiple-valued logic as related to computer science', 'Placeholder abstract for sample data.', 'Yin Cai', @xinwei, '/uploads/sample_paper_402.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Self-plagiarism in computer science', 'Placeholder abstract for sample data.', 'Aaron Nicolson', @loic, '/uploads/sample_paper_403.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Restoring the popularity of computer science', 'Placeholder abstract for sample data.', 'Loic Fosse', @alice, '/uploads/sample_paper_404.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Mathematics for computer science', 'Placeholder abstract for sample data.', 'Xinwei Yang', @dosung, '/uploads/sample_paper_405.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Categories and Computer Science: Frontmatter', 'Placeholder abstract for sample data.', 'Ermo Hua', @kristian, '/uploads/sample_paper_406.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('On the Unusual Effectiveness of Logic in Computer Science', 'Placeholder abstract for sample data.', 'Cara Chen', @zhouhong, '/uploads/sample_paper_407.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Logic for Computer Science', 'Placeholder abstract for sample data.', 'Alice Anderson', @ziyang, '/uploads/sample_paper_408.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('The Computer Science and Engineering Handbook', 'Placeholder abstract for sample data.', 'Loic Fosse', @seunguk, '/uploads/sample_paper_409.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('New Results and New Trends in Computer Science', 'Placeholder abstract for sample data.', 'Alice Anderson', @dosung, '/uploads/sample_paper_410.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Graph-Grammars and Their Application to Computer Science', 'Placeholder abstract for sample data.', 'Srishti Gureja', @wenhan, '/uploads/sample_paper_411.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Computer Science Education Research', 'Placeholder abstract for sample data.', 'Ermo Hua', @jingheng, '/uploads/sample_paper_412.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('The Computer Science and Engineering Handbook', 'Placeholder abstract for sample data.', 'Weiqi Wang', @dosung, '/uploads/sample_paper_413.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Relational Methods in Computer Science', 'Placeholder abstract for sample data.', 'Haokun Liu', @yin, '/uploads/sample_paper_414.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Computer Science Project Work', 'Placeholder abstract for sample data.', 'Weiqi Wang', @ziyang, '/uploads/sample_paper_415.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('COMPUTER SCIENCE DEPARTMENT', 'Placeholder abstract for sample data.', 'Hongzhan Lin', @hongzhan, '/uploads/sample_paper_416.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Categories in Computer Science and Logic', 'Placeholder abstract for sample data.', 'Bo Pan', @kristian, '/uploads/sample_paper_417.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Fundamental Ideas of Computer Science', 'Placeholder abstract for sample data.', 'Haokun Liu', @yin, '/uploads/sample_paper_418.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Category Theory and Computer Science', 'Placeholder abstract for sample data.', 'Kristian Lum', @dosung, '/uploads/sample_paper_419.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Relational Methods in Computer Science', 'Placeholder abstract for sample data.', 'Alice Anderson', @yin, '/uploads/sample_paper_420.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Introduction to probabilistic automata (Computer science and applied mathematics)', 'Placeholder abstract for sample data.', 'Zhouhong Gu', @haokun, '/uploads/sample_paper_421.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Switching and Finite Automata Theory: Computer Science Series', 'Placeholder abstract for sample data.', 'Ziyang Luo', @weiqi, '/uploads/sample_paper_422.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Mathematical Foundations of Computer Science', 'Placeholder abstract for sample data.', 'Jingheng Ye', @bo, '/uploads/sample_paper_423.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Active learning and its use in computer science', 'Placeholder abstract for sample data.', 'Cara Chen', @ziyang, '/uploads/sample_paper_424.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Mathematical Foundations of Computer Science 2004', 'Placeholder abstract for sample data.', 'Yin Cai', @loic, '/uploads/sample_paper_425.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('The Correctness Problem in Computer Science', 'Placeholder abstract for sample data.', 'Xinwei Yang', @xinwei, '/uploads/sample_paper_426.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Mathematics and Computer Science: Coping with Finiteness', 'Placeholder abstract for sample data.', 'Xinwei Yang', @cara, '/uploads/sample_paper_427.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Probability Models for Computer Science', 'Placeholder abstract for sample data.', 'Jingheng Ye', @alice, '/uploads/sample_paper_428.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('In Support of Pair Programming in the Introductory Computer Science Course', 'Placeholder abstract for sample data.', 'Hongzhan Lin', @weiqi, '/uploads/sample_paper_429.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Graph Grammars and Their Application to Computer Science', 'Placeholder abstract for sample data.', 'Srishti Gureja', @seunguk, '/uploads/sample_paper_430.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Research in computer science: an empirical study', 'Placeholder abstract for sample data.', 'Weiqi Wang', @dosung, '/uploads/sample_paper_431.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Graph-Grammars and Their Application to Computer Science and Biology', 'Placeholder abstract for sample data.', 'Ziyang Luo', @yin, '/uploads/sample_paper_432.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Mathematical Foundations of Computer Science 2000', 'Placeholder abstract for sample data.', 'Cara Chen', @xinwei, '/uploads/sample_paper_433.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Department of electrical engineering and computer science', 'Placeholder abstract for sample data.', 'Kristian Lum', @yin, '/uploads/sample_paper_434.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Supporting reflection in introductory computer science', 'Placeholder abstract for sample data.', 'Jingheng Ye', @kristian, '/uploads/sample_paper_435.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Computer Science: An Overview', 'Placeholder abstract for sample data.', 'Loic Fosse', @zhouhong, '/uploads/sample_paper_436.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Calois Connections and Computer Science Applications', 'Placeholder abstract for sample data.', 'Srishti Gureja', @yin, '/uploads/sample_paper_437.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Theoretical Aspects of Computer Science', 'Placeholder abstract for sample data.', 'Weiqi Wang', @srishti, '/uploads/sample_paper_438.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Graph-Theoretic Concepts in Computer Science', 'Placeholder abstract for sample data.', 'Xinwei Yang', @kristian, '/uploads/sample_paper_439.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Department of Computer Science and Technology', 'Placeholder abstract for sample data.', 'Jacy Reese Anthis', @loic, '/uploads/sample_paper_440.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Logic - a foundation for computer science', 'Placeholder abstract for sample data.', 'Aaron Nicolson', @jacy, '/uploads/sample_paper_441.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('From Constructivism to Computer Science', 'Placeholder abstract for sample data.', 'Ermo Hua', @kristian, '/uploads/sample_paper_442.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Journal of Universal Computer Science', 'Placeholder abstract for sample data.', 'Aaron Nicolson', @weiqi, '/uploads/sample_paper_443.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Computer science: an overview', 'Placeholder abstract for sample data.', 'Zhouhong Gu', @dosung, '/uploads/sample_paper_444.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Applied Probability— Computer Science: The Interface', 'Placeholder abstract for sample data.', 'Xinwei Yang', @dosung, '/uploads/sample_paper_445.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Categories and computer science', 'Placeholder abstract for sample data.', 'Zhouhong Gu', @ermo, '/uploads/sample_paper_446.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Independence Results in Computer Science?', 'Placeholder abstract for sample data.', 'Bo Pan', @haokun, '/uploads/sample_paper_447.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Discovery learning in computer science', 'Placeholder abstract for sample data.', 'Cara Chen', @aaron, '/uploads/sample_paper_448.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('An introduction to computer science', 'Placeholder abstract for sample data.', 'Cara Chen', @haokun, '/uploads/sample_paper_449.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Mathematical Foundations of Computer Science 1999', 'Placeholder abstract for sample data.', 'Wenhan Liu', @zhouhong, '/uploads/sample_paper_450.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Proceedings of the 30th IEEE symposium on Foundations of computer science', 'Placeholder abstract for sample data.', 'Aaron Nicolson', @cara, '/uploads/sample_paper_451.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Randomization and Approximation Techniques in Computer Science', 'Placeholder abstract for sample data.', 'Haokun Liu', @hongzhan, '/uploads/sample_paper_452.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Logic and computer science', 'Placeholder abstract for sample data.', 'Ermo Hua', @jingheng, '/uploads/sample_paper_453.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Computer Science 2', 'Placeholder abstract for sample data.', 'Junlin Li', @jingheng, '/uploads/sample_paper_454.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Information and Computer Science', 'Placeholder abstract for sample data.', 'Ermo Hua', @cara, '/uploads/sample_paper_455.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Mathematics and Computer Science', 'Placeholder abstract for sample data.', 'Jingheng Ye', @alice, '/uploads/sample_paper_456.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Computer science Logo style', 'Placeholder abstract for sample data.', 'Alice Anderson', @weiqi, '/uploads/sample_paper_457.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Computer Science Logic', 'Placeholder abstract for sample data.', 'Ziyang Luo', @srishti, '/uploads/sample_paper_458.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Combinatorics and Computer Science', 'Placeholder abstract for sample data.', 'Ziyang Luo', @wenhan, '/uploads/sample_paper_459.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Graph Transformations in Computer Science', 'Placeholder abstract for sample data.', 'Ermo Hua', @yin, '/uploads/sample_paper_460.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Structures in Logic and Computer Science', 'Placeholder abstract for sample data.', 'Jacy Reese Anthis', @bo, '/uploads/sample_paper_461.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Genetic programming - An Introduction: On the Automatic Evolution of Computer Programs and Its Applications', 'Placeholder abstract for sample data.', 'Hongzhan Lin', @srishti, '/uploads/sample_paper_462.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Computer-Guided Inquiry to Improve Science Learning', 'Placeholder abstract for sample data.', 'Jacy Reese Anthis', @cara, '/uploads/sample_paper_463.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('The Book of Why: The New Science of Cause and Effect†', 'Placeholder abstract for sample data.', 'Srishti Gureja', @alice, '/uploads/sample_paper_464.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Complexity : the emerging science and the edge of order and chaos', 'Placeholder abstract for sample data.', 'Ziyang Luo', @jingheng, '/uploads/sample_paper_465.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Computer Science and Computer Science Education', 'Placeholder abstract for sample data.', 'Cara Chen', @xinwei, '/uploads/sample_paper_466.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('The Science And Engineering Of Materials', 'Placeholder abstract for sample data.', 'Cara Chen', @zhouhong, '/uploads/sample_paper_467.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Fundamentals Of Materials Science And Engineering An Integrated Approach', 'Placeholder abstract for sample data.', 'Yin Cai', @xinwei, '/uploads/sample_paper_468.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Six Degrees: The Science of a Connected Age', 'Placeholder abstract for sample data.', 'Kristian Lum', @jacy, '/uploads/sample_paper_469.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Learning science through computer games and simulations', 'Placeholder abstract for sample data.', 'Dosung Lee', @haokun, '/uploads/sample_paper_470.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Computer Simulation in Management Science (3rd Edition)', 'Placeholder abstract for sample data.', 'Cara Chen', @alice, '/uploads/sample_paper_471.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Developing the next generation of diverse computer scientists: the need for enhanced, intersectional computing identity theory', 'Placeholder abstract for sample data.', 'Wenhan Liu', @ziyang, '/uploads/sample_paper_472.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Science in the Age of Computer Simulation', 'Placeholder abstract for sample data.', 'Jingheng Ye', @bo, '/uploads/sample_paper_473.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Explaining Creativity: The Science of Human Innovation', 'Placeholder abstract for sample data.', 'Ziyang Luo', @loic, '/uploads/sample_paper_474.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Computer Methods in Applied Mechanics and Engineering', 'Placeholder abstract for sample data.', 'Alice Anderson', @xinwei, '/uploads/sample_paper_475.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('What is Cognitive Science', 'Placeholder abstract for sample data.', 'Xinwei Yang', @dosung, '/uploads/sample_paper_476.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Teacher Change Following a Professional Development Experience in Integrating Computational Thinking into Elementary Science', 'Placeholder abstract for sample data.', 'Dosung Lee', @dosung, '/uploads/sample_paper_477.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('ENCYCLOPEDIA OF Surface and Colloid Science', 'Placeholder abstract for sample data.', 'Bo Pan', @junlin, '/uploads/sample_paper_478.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Data and Computer Communications', 'Placeholder abstract for sample data.', 'Loic Fosse', @aaron, '/uploads/sample_paper_479.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Towards Data Science', 'Placeholder abstract for sample data.', 'Jacy Reese Anthis', @srishti, '/uploads/sample_paper_480.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('The “New” Science of Networks', 'Placeholder abstract for sample data.', 'Weiqi Wang', @ziyang, '/uploads/sample_paper_481.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Effects of Feedback in a Computer-Based Learning Environment on Students’ Learning Outcomes', 'Placeholder abstract for sample data.', 'Dosung Lee', @yin, '/uploads/sample_paper_482.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('New Pedagogies on Teaching Science with Computer Simulations', 'Placeholder abstract for sample data.', 'Aaron Nicolson', @seunguk, '/uploads/sample_paper_483.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Numerical Optimization', 'Placeholder abstract for sample data.', 'Yin Cai', @weiqi, '/uploads/sample_paper_484.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('TensorFlow: Large-Scale Machine Learning on Heterogeneous Distributed Systems', 'Placeholder abstract for sample data.', 'Junlin Li', @dosung, '/uploads/sample_paper_485.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('An introduction to statistical learning with applications in R', 'Placeholder abstract for sample data.', 'Aaron Nicolson', @xinwei, '/uploads/sample_paper_486.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('An Introduction to Optimization on Smooth Manifolds', 'Placeholder abstract for sample data.', 'Seunguk Yu', @weiqi, '/uploads/sample_paper_487.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('The Stereotypical Computer Scientist: Gendered Media Representations as a Barrier to Inclusion for Women', 'Placeholder abstract for sample data.', 'Cara Chen', @jacy, '/uploads/sample_paper_488.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Learning Science through Computer Games and Simulations.', 'Placeholder abstract for sample data.', 'Loic Fosse', @zhouhong, '/uploads/sample_paper_489.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Human-computer interaction: psychology as a science of design', 'Placeholder abstract for sample data.', 'Alice Anderson', @haokun, '/uploads/sample_paper_490.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Julia: A Fresh Approach to Numerical Computing', 'Placeholder abstract for sample data.', 'Junlin Li', @weiqi, '/uploads/sample_paper_491.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Fiji: an open-source platform for biological-image analysis', 'Placeholder abstract for sample data.', 'Dosung Lee', @cara, '/uploads/sample_paper_492.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Quantum Computation and Quantum Information', 'Placeholder abstract for sample data.', 'Hongzhan Lin', @srishti, '/uploads/sample_paper_493.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('arXiv', 'Placeholder abstract for sample data.', 'Dosung Lee', @jingheng, '/uploads/sample_paper_494.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Machine learning: Trends, perspectives, and prospects', 'Placeholder abstract for sample data.', 'Junlin Li', @jacy, '/uploads/sample_paper_495.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('The Computer for the 21st Century (1991)', 'Placeholder abstract for sample data.', 'Weiqi Wang', @ziyang, '/uploads/sample_paper_496.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Sentiment Analysis and Opinion Mining', 'Placeholder abstract for sample data.', 'Wenhan Liu', @haokun, '/uploads/sample_paper_497.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('The computer and the mind: an introduction to cognitive science', 'Placeholder abstract for sample data.', 'Haokun Liu', @dosung, '/uploads/sample_paper_498.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Science of Computer Programming', 'Placeholder abstract for sample data.', 'Seunguk Yu', @zhouhong, '/uploads/sample_paper_499.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Understanding Machine Learning - From Theory to Algorithms', 'Placeholder abstract for sample data.', 'Yin Cai', @junlin, '/uploads/sample_paper_500.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Fiji: an open-source platform for biological-image analysis', 'Placeholder abstract for sample data.', 'Wenhan Liu', @hongzhan, '/uploads/sample_paper_501.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Quantum Computation and Quantum Information', 'Placeholder abstract for sample data.', 'Yin Cai', @jacy, '/uploads/sample_paper_502.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('arXiv', 'Placeholder abstract for sample data.', 'Ermo Hua', @cara, '/uploads/sample_paper_503.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Machine learning: Trends, perspectives, and prospects', 'Placeholder abstract for sample data.', 'Ziyang Luo', @wenhan, '/uploads/sample_paper_504.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('The Computer for the 21st Century (1991)', 'Placeholder abstract for sample data.', 'Loic Fosse', @loic, '/uploads/sample_paper_505.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Sentiment Analysis and Opinion Mining', 'Placeholder abstract for sample data.', 'Kristian Lum', @haokun, '/uploads/sample_paper_506.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('The computer and the mind: an introduction to cognitive science', 'Placeholder abstract for sample data.', 'Srishti Gureja', @bo, '/uploads/sample_paper_507.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Science of Computer Programming', 'Placeholder abstract for sample data.', 'Srishti Gureja', @xinwei, '/uploads/sample_paper_508.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Understanding Machine Learning - From Theory to Algorithms', 'Placeholder abstract for sample data.', 'Kristian Lum', @alice, '/uploads/sample_paper_509.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Quantum Computation and Quantum Information: Introduction to the Tenth Anniversary Edition', 'Placeholder abstract for sample data.', 'Kristian Lum', @dosung, '/uploads/sample_paper_510.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Swarm Intelligence', 'Placeholder abstract for sample data.', 'Haokun Liu', @dosung, '/uploads/sample_paper_511.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Quantum Computation and Quantum Information (10th Anniversary edition)', 'Placeholder abstract for sample data.', 'Weiqi Wang', @alice, '/uploads/sample_paper_512.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('The organization of the human cerebral cortex estimated by intrinsic functional connectivity', 'Placeholder abstract for sample data.', 'Xinwei Yang', @seunguk, '/uploads/sample_paper_513.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Neural Networks and Learning Machines', 'Placeholder abstract for sample data.', 'Loic Fosse', @wenhan, '/uploads/sample_paper_514.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Supplementary for: Deep learning with convolutional neural networks for EEG decoding and visualization', 'Placeholder abstract for sample data.', 'Weiqi Wang', @ermo, '/uploads/sample_paper_515.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('The future of citizen science: emerging technologies and shifting paradigms', 'Placeholder abstract for sample data.', 'Zhouhong Gu', @yin, '/uploads/sample_paper_516.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Power laws, Pareto distributions and Zipf''s law', 'Placeholder abstract for sample data.', 'Haokun Liu', @jacy, '/uploads/sample_paper_517.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Formal Concept Analysis: Mathematical Foundations', 'Placeholder abstract for sample data.', 'Seunguk Yu', @srishti, '/uploads/sample_paper_518.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Reasoning about knowledge', 'Placeholder abstract for sample data.', 'Jingheng Ye', @srishti, '/uploads/sample_paper_519.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Simulation Modeling and Analysis', 'Placeholder abstract for sample data.', 'Srishti Gureja', @hongzhan, '/uploads/sample_paper_520.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Reinforcement Learning: A Survey', 'Placeholder abstract for sample data.', 'Ziyang Luo', @junlin, '/uploads/sample_paper_521.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Differential Evolution - A simple and efficient adaptive scheme for global optimization over continuous spaces', 'Placeholder abstract for sample data.', 'Kristian Lum', @haokun, '/uploads/sample_paper_522.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Modern factor analysis', 'Placeholder abstract for sample data.', 'Zhouhong Gu', @dosung, '/uploads/sample_paper_523.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Review : Multimedia Encoding Techniques Review : MPEG : A Video Compression Standard for Multimedia Applications', 'Placeholder abstract for sample data.', 'Haokun Liu', @bo, '/uploads/sample_paper_524.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Algorithmic game theory', 'Placeholder abstract for sample data.', 'Aaron Nicolson', @cara, '/uploads/sample_paper_525.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Introduction to the non-asymptotic analysis of random matrices', 'Placeholder abstract for sample data.', 'Xinwei Yang', @dosung, '/uploads/sample_paper_526.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('A Mathematical Introduction to Compressive Sensing', 'Placeholder abstract for sample data.', 'Kristian Lum', @wenhan, '/uploads/sample_paper_527.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Introduction to probability models', 'Placeholder abstract for sample data.', 'Srishti Gureja', @aaron, '/uploads/sample_paper_528.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Where the action is', 'Placeholder abstract for sample data.', 'Yin Cai', @weiqi, '/uploads/sample_paper_529.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('The C Programming Language', 'Placeholder abstract for sample data.', 'Jacy Reese Anthis', @zhouhong, '/uploads/sample_paper_530.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Particle swarm optimization: developments, applications and resources', 'Placeholder abstract for sample data.', 'Zhouhong Gu', @zhouhong, '/uploads/sample_paper_531.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('The structure of scientific collaboration networks.', 'Placeholder abstract for sample data.', 'Ziyang Luo', @haokun, '/uploads/sample_paper_532.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('An Introduction to MultiAgent Systems', 'Placeholder abstract for sample data.', 'Ziyang Luo', @hongzhan, '/uploads/sample_paper_533.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Statistical learning theory', 'Placeholder abstract for sample data.', 'Ermo Hua', @aaron, '/uploads/sample_paper_534.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Convex Optimization', 'Placeholder abstract for sample data.', 'Hongzhan Lin', @haokun, '/uploads/sample_paper_535.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Survey of clustering algorithms', 'Placeholder abstract for sample data.', 'Junlin Li', @ermo, '/uploads/sample_paper_536.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('The neural basis of decision making.', 'Placeholder abstract for sample data.', 'Hongzhan Lin', @aaron, '/uploads/sample_paper_537.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('The interdisciplinary study of coordination', 'Placeholder abstract for sample data.', 'Loic Fosse', @weiqi, '/uploads/sample_paper_538.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Voronoi diagrams—a survey of a fundamental geometric data structure', 'Placeholder abstract for sample data.', 'Bo Pan', @junlin, '/uploads/sample_paper_539.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('An introduction to genetic algorithms', 'Placeholder abstract for sample data.', 'Bo Pan', @hongzhan, '/uploads/sample_paper_540.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('About the authors', 'Placeholder abstract for sample data.', 'Srishti Gureja', @srishti, '/uploads/sample_paper_541.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Linear logic', 'Placeholder abstract for sample data.', 'Yin Cai', @zhouhong, '/uploads/sample_paper_542.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Spline Functions: Basic Theory', 'Placeholder abstract for sample data.', 'Bo Pan', @srishti, '/uploads/sample_paper_543.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Bayesian reasoning and machine learning', 'Placeholder abstract for sample data.', 'Yin Cai', @jingheng, '/uploads/sample_paper_544.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('The Prospects for Psychological Science in Human-Computer Interaction', 'Placeholder abstract for sample data.', 'Loic Fosse', @seunguk, '/uploads/sample_paper_545.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Simulation Modeling and Analysis', 'Placeholder abstract for sample data.', 'Cara Chen', @jacy, '/uploads/sample_paper_546.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Computation and Cognition: Toward a Foundation for Cognitive Science', 'Placeholder abstract for sample data.', 'Jingheng Ye', @weiqi, '/uploads/sample_paper_547.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('From molecular to modular cell biology', 'Placeholder abstract for sample data.', 'Srishti Gureja', @cara, '/uploads/sample_paper_548.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('The case for open computer programs', 'Placeholder abstract for sample data.', 'Cara Chen', @bo, '/uploads/sample_paper_549.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('A Method of Automated Nonparametric Content Analysis for Social Science', 'Placeholder abstract for sample data.', 'Zhouhong Gu', @yin, '/uploads/sample_paper_550.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('A Comprehensive Survey of Clustering Algorithms', 'Placeholder abstract for sample data.', 'Haokun Liu', @ziyang, '/uploads/sample_paper_551.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Computer Simulation and the Philosophy of Science', 'Placeholder abstract for sample data.', 'Xinwei Yang', @aaron, '/uploads/sample_paper_552.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Encyclopedia of Distances', 'Placeholder abstract for sample data.', 'Cara Chen', @bo, '/uploads/sample_paper_553.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Adapting computational text analysis to social science (and vice versa)', 'Placeholder abstract for sample data.', 'Cara Chen', @jingheng, '/uploads/sample_paper_554.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Techniques and applications for sentiment analysis', 'Placeholder abstract for sample data.', 'Srishti Gureja', @alice, '/uploads/sample_paper_555.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('High-resolution structure of a retroviral protease folded as a monomer', 'Placeholder abstract for sample data.', 'Haokun Liu', @dosung, '/uploads/sample_paper_556.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Computer as thinker/doer: problem-solving environments for computational science', 'Placeholder abstract for sample data.', 'Ziyang Luo', @seunguk, '/uploads/sample_paper_557.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Graph Theory', 'Placeholder abstract for sample data.', 'Weiqi Wang', @xinwei, '/uploads/sample_paper_558.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Fixed Point Theory', 'Placeholder abstract for sample data.', 'Seunguk Yu', @cara, '/uploads/sample_paper_559.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('The Netflix Prize', 'Placeholder abstract for sample data.', 'Cara Chen', @jingheng, '/uploads/sample_paper_560.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Eye Tracking Methodology: Theory and Practice', 'Placeholder abstract for sample data.', 'Haokun Liu', @zhouhong, '/uploads/sample_paper_561.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Why Are Some STEM Fields More Gender Balanced Than Others?', 'Placeholder abstract for sample data.', 'Haokun Liu', @aaron, '/uploads/sample_paper_562.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Computational Topology: An Introduction', 'Placeholder abstract for sample data.', 'Cara Chen', @bo, '/uploads/sample_paper_563.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Signals and Systems', 'Placeholder abstract for sample data.', 'Seunguk Yu', @junlin, '/uploads/sample_paper_564.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Artificial Intelligence: A Guide to Intelligent Systems', 'Placeholder abstract for sample data.', 'Xinwei Yang', @junlin, '/uploads/sample_paper_565.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('What do you mean by collaborative learning', 'Placeholder abstract for sample data.', 'Wenhan Liu', @junlin, '/uploads/sample_paper_566.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Expander Graphs and their Applications', 'Placeholder abstract for sample data.', 'Wenhan Liu', @aaron, '/uploads/sample_paper_567.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Digital systems testing and testable design', 'Placeholder abstract for sample data.', 'Yin Cai', @ziyang, '/uploads/sample_paper_568.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('All of Statistics: A Concise Course in Statistical Inference', 'Placeholder abstract for sample data.', 'Junlin Li', @jingheng, '/uploads/sample_paper_569.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Computer simulations in the high school: Students'' cognitive stages, science process skills and academic achievement in microbiology', 'Placeholder abstract for sample data.', 'Jacy Reese Anthis', @junlin, '/uploads/sample_paper_570.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('A Meta-analysis of the Effectiveness of Computer-Assisted Instruction in Science Education', 'Placeholder abstract for sample data.', 'Xinwei Yang', @jingheng, '/uploads/sample_paper_571.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Scientific collaboration networks. II. Shortest paths, weighted networks, and centrality.', 'Placeholder abstract for sample data.', 'Bo Pan', @jacy, '/uploads/sample_paper_572.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Formal Ontology and Information Systems', 'Placeholder abstract for sample data.', 'Ziyang Luo', @loic, '/uploads/sample_paper_573.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Engineering Optimization: An Introduction with Metaheuristic Applications', 'Placeholder abstract for sample data.', 'Yin Cai', @aaron, '/uploads/sample_paper_574.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('A Fistful of Bitcoins Characterizing Payments Among Men with No Names', 'Placeholder abstract for sample data.', 'Bo Pan', @zhouhong, '/uploads/sample_paper_575.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Artificial intelligence in healthcare: transforming the practice of medicine', 'Placeholder abstract for sample data.', 'Bo Pan', @yin, '/uploads/sample_paper_576.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Handbook of Computational Social Choice', 'Placeholder abstract for sample data.', 'Junlin Li', @ziyang, '/uploads/sample_paper_577.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Scientific collaboration networks. I. Network construction and fundamental results.', 'Placeholder abstract for sample data.', 'Hongzhan Lin', @wenhan, '/uploads/sample_paper_578.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Data streams: algorithms and applications', 'Placeholder abstract for sample data.', 'Ermo Hua', @xinwei, '/uploads/sample_paper_579.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Networks, Crowds, and Markets: Reasoning about a Highly Connected World (Easley, D. and Kleinberg, J.; 2010) [Book Review]', 'Placeholder abstract for sample data.', 'Xinwei Yang', @xinwei, '/uploads/sample_paper_580.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Using Computer Animated Graphics in Science Instruction with Children', 'Placeholder abstract for sample data.', 'Wenhan Liu', @jingheng, '/uploads/sample_paper_581.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('A Brief History of Generative Models for Power Law and Lognormal Distributions', 'Placeholder abstract for sample data.', 'Jingheng Ye', @srishti, '/uploads/sample_paper_582.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('The creative mind : myths & mechanisms', 'Placeholder abstract for sample data.', 'Loic Fosse', @kristian, '/uploads/sample_paper_583.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('A million spiking-neuron integrated circuit with a scalable communication network and interface', 'Placeholder abstract for sample data.', 'Aaron Nicolson', @ermo, '/uploads/sample_paper_584.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Issues in computer supported inquiry learning in science', 'Placeholder abstract for sample data.', 'Loic Fosse', @alice, '/uploads/sample_paper_585.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Verification of Computer Codes in Computational Science and Engineering', 'Placeholder abstract for sample data.', 'Kristian Lum', @jacy, '/uploads/sample_paper_586.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Networks: An Introduction', 'Placeholder abstract for sample data.', 'Dosung Lee', @zhouhong, '/uploads/sample_paper_587.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Digital Evidence and Computer Crime: Forensic Science, Computers and the Internet', 'Placeholder abstract for sample data.', 'Seunguk Yu', @bo, '/uploads/sample_paper_588.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('LEDA: a platform for combinatorial and geometric computing', 'Placeholder abstract for sample data.', 'Dosung Lee', @jingheng, '/uploads/sample_paper_589.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Introduction to the Theory of Computation', 'Placeholder abstract for sample data.', 'Loic Fosse', @aaron, '/uploads/sample_paper_590.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Quantum random walks: An introductory overview', 'Placeholder abstract for sample data.', 'Hongzhan Lin', @bo, '/uploads/sample_paper_591.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Towards artificial general intelligence with hybrid Tianjic chip architecture', 'Placeholder abstract for sample data.', 'Srishti Gureja', @yin, '/uploads/sample_paper_592.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Quantum computers', 'Placeholder abstract for sample data.', 'Ziyang Luo', @alice, '/uploads/sample_paper_593.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Combinatorial Optimization: Algorithms and Complexity', 'Placeholder abstract for sample data.', 'Cara Chen', @jacy, '/uploads/sample_paper_594.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Conceptual Change in Science through Collaborative Learning at the Computer.', 'Placeholder abstract for sample data.', 'Seunguk Yu', @yin, '/uploads/sample_paper_595.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('The Graph Neural Network Model', 'Placeholder abstract for sample data.', 'Alice Anderson', @dosung, '/uploads/sample_paper_596.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Building Ontologies with Basic Formal Ontology', 'Placeholder abstract for sample data.', 'Weiqi Wang', @ziyang, '/uploads/sample_paper_597.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Cramming More Components Onto Integrated Circuits', 'Placeholder abstract for sample data.', 'Hongzhan Lin', @jingheng, '/uploads/sample_paper_598.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Tuning In, Tuning Out: The Strange Disappearance of Social Capital in America', 'Placeholder abstract for sample data.', 'Hongzhan Lin', @ermo, '/uploads/sample_paper_599.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Participant Observation', 'Placeholder abstract for sample data.', 'Xinwei Yang', @dosung, '/uploads/sample_paper_600.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Machine behaviour', 'Placeholder abstract for sample data.', 'Bo Pan', @wenhan, '/uploads/sample_paper_601.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Applied statistics for the behavioral sciences', 'Placeholder abstract for sample data.', 'Yin Cai', @zhouhong, '/uploads/sample_paper_602.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Cloud Computing Principles and Paradigms', 'Placeholder abstract for sample data.', 'Wenhan Liu', @kristian, '/uploads/sample_paper_603.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Dynamic Programming', 'Placeholder abstract for sample data.', 'Yin Cai', @haokun, '/uploads/sample_paper_604.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Geometric Deep Learning on Graphs and Manifolds Using Mixture Model CNNs', 'Placeholder abstract for sample data.', 'Zhouhong Gu', @bo, '/uploads/sample_paper_605.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Computer Ethics: New Study Area for Engineering Science Students.', 'Placeholder abstract for sample data.', 'Alice Anderson', @aaron, '/uploads/sample_paper_606.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('PERSPECTIVE: COMPLEX ADAPTATIONS AND THE EVOLUTION OF EVOLVABILITY', 'Placeholder abstract for sample data.', 'Loic Fosse', @wenhan, '/uploads/sample_paper_607.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Stochastic Modeling and the Theory of Queues', 'Placeholder abstract for sample data.', 'Aaron Nicolson', @hongzhan, '/uploads/sample_paper_608.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Vegetation Description and Analysis: A Practical Approach', 'Placeholder abstract for sample data.', 'Haokun Liu', @ermo, '/uploads/sample_paper_609.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Distributed cognition', 'Placeholder abstract for sample data.', 'Jingheng Ye', @jacy, '/uploads/sample_paper_610.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('The Way We Think: Conceptual Blending and the Mind''''s Hidden Complexities. Basic Books', 'Placeholder abstract for sample data.', 'Aaron Nicolson', @alice, '/uploads/sample_paper_611.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Simulation for the social scientist', 'Placeholder abstract for sample data.', 'Junlin Li', @haokun, '/uploads/sample_paper_612.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Returns to science: computer networks in oceanography', 'Placeholder abstract for sample data.', 'Xinwei Yang', @haokun, '/uploads/sample_paper_613.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('The Computer Revolution in Philosophy: Philosophy, Science, and Models of Mind', 'Placeholder abstract for sample data.', 'Junlin Li', @bo, '/uploads/sample_paper_614.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Multiobjective optimization Test Instances for the CEC 2009 Special Session and Competition', 'Placeholder abstract for sample data.', 'Jingheng Ye', @cara, '/uploads/sample_paper_615.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('All-optical machine learning using diffractive deep neural networks', 'Placeholder abstract for sample data.', 'Seunguk Yu', @bo, '/uploads/sample_paper_616.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Legged Robots That Balance', 'Placeholder abstract for sample data.', 'Bo Pan', @alice, '/uploads/sample_paper_617.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('ELF: The Electron Localization Function', 'Placeholder abstract for sample data.', 'Weiqi Wang', @weiqi, '/uploads/sample_paper_618.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('A Computer-Assisted Approach to Diagnosing Student Learning Problems in Science courses', 'Placeholder abstract for sample data.', 'Junlin Li', @kristian, '/uploads/sample_paper_619.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('The Bioperl toolkit: Perl modules for the life sciences.', 'Placeholder abstract for sample data.', 'Yin Cai', @seunguk, '/uploads/sample_paper_620.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('The History of Nanoscience and Nanotechnology: From Chemical–Physical Applications to Nanomedicine', 'Placeholder abstract for sample data.', 'Alice Anderson', @aaron, '/uploads/sample_paper_621.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Combining Machine Learning and Computational Chemistry for Predictive Insights Into Chemical Systems', 'Placeholder abstract for sample data.', 'Cara Chen', @yin, '/uploads/sample_paper_622.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Computer Software in Science and Mathematics.', 'Placeholder abstract for sample data.', 'Wenhan Liu', @jacy, '/uploads/sample_paper_623.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('The science of computer benchmarking', 'Placeholder abstract for sample data.', 'Dosung Lee', @wenhan, '/uploads/sample_paper_624.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('The Semiotic Engineering of Human-Computer Interaction', 'Placeholder abstract for sample data.', 'Bo Pan', @ermo, '/uploads/sample_paper_625.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Agent Theories, Architectures, and Languages: A Survey', 'Placeholder abstract for sample data.', 'Aaron Nicolson', @bo, '/uploads/sample_paper_626.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Stable Adaptive Teleoperation', 'Placeholder abstract for sample data.', 'Junlin Li', @yin, '/uploads/sample_paper_627.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Statistical Analysis of Network Data', 'Placeholder abstract for sample data.', 'Kristian Lum', @wenhan, '/uploads/sample_paper_628.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Faster sequential genetic linkage computations.', 'Placeholder abstract for sample data.', 'Dosung Lee', @cara, '/uploads/sample_paper_629.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Design Research Through Practice: From the Lab, Field, and Showroom', 'Placeholder abstract for sample data.', 'Jacy Reese Anthis', @haokun, '/uploads/sample_paper_630.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Communications of the ACM', 'Placeholder abstract for sample data.', 'Junlin Li', @weiqi, '/uploads/sample_paper_631.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Algorithms, games, and the internet', 'Placeholder abstract for sample data.', 'Bo Pan', @alice, '/uploads/sample_paper_632.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('The View from Above: Applications of Satellite Data in Economics', 'Placeholder abstract for sample data.', 'Loic Fosse', @jingheng, '/uploads/sample_paper_633.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Simulation: The Practice of Model Development and Use', 'Placeholder abstract for sample data.', 'Bo Pan', @junlin, '/uploads/sample_paper_634.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Elements of Finite Model Theory', 'Placeholder abstract for sample data.', 'Wenhan Liu', @seunguk, '/uploads/sample_paper_635.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('The CIPRES science gateway: a community resource for phylogenetic analyses', 'Placeholder abstract for sample data.', 'Haokun Liu', @bo, '/uploads/sample_paper_636.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Outlier Detection in High Dimensional Data', 'Placeholder abstract for sample data.', 'Aaron Nicolson', @ziyang, '/uploads/sample_paper_637.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Students’ Misconceptions and Other Difficulties in Introductory Programming', 'Placeholder abstract for sample data.', 'Junlin Li', @srishti, '/uploads/sample_paper_638.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('eDoctor: machine learning and the future of medicine', 'Placeholder abstract for sample data.', 'Haokun Liu', @jingheng, '/uploads/sample_paper_639.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Computing in Everyday Life: A Call for Research on Experiential Computing', 'Placeholder abstract for sample data.', 'Haokun Liu', @xinwei, '/uploads/sample_paper_640.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Introduction to Evolutionary Computing', 'Placeholder abstract for sample data.', 'Alice Anderson', @srishti, '/uploads/sample_paper_641.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Handbook of Formal Languages', 'Placeholder abstract for sample data.', 'Zhouhong Gu', @zhouhong, '/uploads/sample_paper_642.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Recent Developments in', 'Placeholder abstract for sample data.', 'Weiqi Wang', @weiqi, '/uploads/sample_paper_643.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('The Art and Science of Computer Security', 'Placeholder abstract for sample data.', 'Junlin Li', @bo, '/uploads/sample_paper_644.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Local Search in Combinatorial Optimisation.', 'Placeholder abstract for sample data.', 'Junlin Li', @junlin, '/uploads/sample_paper_645.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Optimal alignments in linear space', 'Placeholder abstract for sample data.', 'Yin Cai', @srishti, '/uploads/sample_paper_646.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Computer Simulation in Materials Science', 'Placeholder abstract for sample data.', 'Xinwei Yang', @aaron, '/uploads/sample_paper_647.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Brain-Computer Interface in Stroke Rehabilitation', 'Placeholder abstract for sample data.', 'Srishti Gureja', @cara, '/uploads/sample_paper_648.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Cryptography and Data Security', 'Placeholder abstract for sample data.', 'Cara Chen', @alice, '/uploads/sample_paper_649.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('The Scientific Research Potential of Virtual Worlds', 'Placeholder abstract for sample data.', 'Ermo Hua', @loic, '/uploads/sample_paper_650.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Handbook of Pattern Recognition and Computer Vision', 'Placeholder abstract for sample data.', 'Kristian Lum', @wenhan, '/uploads/sample_paper_651.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Combinatorial Group Testing and Its Applications', 'Placeholder abstract for sample data.', 'Junlin Li', @loic, '/uploads/sample_paper_652.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Design Science Research Evaluation', 'Placeholder abstract for sample data.', 'Dosung Lee', @jacy, '/uploads/sample_paper_653.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('A breadth-first survey of eye-tracking applications', 'Placeholder abstract for sample data.', 'Yin Cai', @bo, '/uploads/sample_paper_654.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Networks', 'Placeholder abstract for sample data.', 'Junlin Li', @weiqi, '/uploads/sample_paper_655.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
(': Student', 'Placeholder abstract for sample data.', 'Zhouhong Gu', @ermo, '/uploads/sample_paper_656.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Elements of noncommutative geometry', 'Placeholder abstract for sample data.', 'Zhouhong Gu', @ziyang, '/uploads/sample_paper_657.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('An Introduction to Kolmogorov Complexity and Its Applications', 'Placeholder abstract for sample data.', 'Loic Fosse', @ermo, '/uploads/sample_paper_658.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Adiabatic quantum computation is equivalent to standard quantum computation', 'Placeholder abstract for sample data.', 'Wenhan Liu', @hongzhan, '/uploads/sample_paper_659.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Virtual Reality', 'Placeholder abstract for sample data.', 'Wenhan Liu', @ziyang, '/uploads/sample_paper_660.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Numerical optimization techniques for engineering design', 'Placeholder abstract for sample data.', 'Srishti Gureja', @kristian, '/uploads/sample_paper_661.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Trending: The Promises and the Challenges of Big Social Data', 'Placeholder abstract for sample data.', 'Srishti Gureja', @kristian, '/uploads/sample_paper_662.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Topic Modeling in Management Research: Rendering New Theory from Textual Data', 'Placeholder abstract for sample data.', 'Weiqi Wang', @loic, '/uploads/sample_paper_663.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Network Science', 'Placeholder abstract for sample data.', 'Hongzhan Lin', @yin, '/uploads/sample_paper_664.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Text mining and visualization using VOSviewer', 'Placeholder abstract for sample data.', 'Yin Cai', @haokun, '/uploads/sample_paper_665.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Specification', 'Placeholder abstract for sample data.', 'Loic Fosse', @cara, '/uploads/sample_paper_666.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Raspberry Pi', 'Placeholder abstract for sample data.', 'Haokun Liu', @loic, '/uploads/sample_paper_667.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('DNA solution of hard computational problems.', 'Placeholder abstract for sample data.', 'Aaron Nicolson', @yin, '/uploads/sample_paper_668.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('A multi-national, multi-institutional study of assessment of programming skills of first-year CS students', 'Placeholder abstract for sample data.', 'Ziyang Luo', @wenhan, '/uploads/sample_paper_669.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Numerical Geometry of Non-Rigid Shapes', 'Placeholder abstract for sample data.', 'Ermo Hua', @cara, '/uploads/sample_paper_670.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Monte Carlo and molecular dynamics simulations in polymer science', 'Placeholder abstract for sample data.', 'Yin Cai', @bo, '/uploads/sample_paper_671.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Cscl : Theory and Practice of An Emerging Paradigm', 'Placeholder abstract for sample data.', 'Bo Pan', @xinwei, '/uploads/sample_paper_672.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Python: the tutorial', 'Placeholder abstract for sample data.', 'Srishti Gureja', @alice, '/uploads/sample_paper_673.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Elements of Automata Theory', 'Placeholder abstract for sample data.', 'Ermo Hua', @kristian, '/uploads/sample_paper_674.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Physical Symbol Systems', 'Placeholder abstract for sample data.', 'Dosung Lee', @srishti, '/uploads/sample_paper_675.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Formal languages and their relation to automata', 'Placeholder abstract for sample data.', 'Haokun Liu', @hongzhan, '/uploads/sample_paper_676.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Eigenvalues and expanders', 'Placeholder abstract for sample data.', 'Bo Pan', @alice, '/uploads/sample_paper_677.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('The Legion vision of a worldwide virtual computer', 'Placeholder abstract for sample data.', 'Bo Pan', @yin, '/uploads/sample_paper_678.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('An Introduction to Formal Languages and Automata', 'Placeholder abstract for sample data.', 'Xinwei Yang', @xinwei, '/uploads/sample_paper_679.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Artificial Intelligence with Uncertainty', 'Placeholder abstract for sample data.', 'Loic Fosse', @hongzhan, '/uploads/sample_paper_680.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Neural-Symbolic Learning and Reasoning: A Survey and Interpretation', 'Placeholder abstract for sample data.', 'Ziyang Luo', @ermo, '/uploads/sample_paper_681.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('A K-6 Computational Thinking Curriculum Framework: Implications for Teacher Knowledge', 'Placeholder abstract for sample data.', 'Bo Pan', @dosung, '/uploads/sample_paper_682.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Changing Minds: Computers, Learning, and Literacy', 'Placeholder abstract for sample data.', 'Jingheng Ye', @junlin, '/uploads/sample_paper_683.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Advanced computer architecture : parallelism, scalability, programmability /edited by Kai Hwang', 'Placeholder abstract for sample data.', 'Srishti Gureja', @srishti, '/uploads/sample_paper_684.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('A blueprint for demonstrating quantum supremacy with superconducting qubits', 'Placeholder abstract for sample data.', 'Hongzhan Lin', @haokun, '/uploads/sample_paper_685.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Vision Science : Photons to Phenomenology', 'Placeholder abstract for sample data.', 'Jacy Reese Anthis', @loic, '/uploads/sample_paper_686.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('The Deluge of Spurious Correlations in Big Data', 'Placeholder abstract for sample data.', 'Zhouhong Gu', @jacy, '/uploads/sample_paper_687.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Mathematical elements for computer graphics', 'Placeholder abstract for sample data.', 'Kristian Lum', @kristian, '/uploads/sample_paper_688.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Understanding Machine Learning: From Theory to Algorithms', 'Placeholder abstract for sample data.', 'Junlin Li', @zhouhong, '/uploads/sample_paper_689.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Structural Dynamics: An Introduction to Computer Methods', 'Placeholder abstract for sample data.', 'Yin Cai', @alice, '/uploads/sample_paper_690.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Boolean Function Complexity Advances and Frontiers', 'Placeholder abstract for sample data.', 'Loic Fosse', @junlin, '/uploads/sample_paper_691.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Fractals, scaling, and growth far from equilibrium', 'Placeholder abstract for sample data.', 'Alice Anderson', @weiqi, '/uploads/sample_paper_692.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('A systematic review of randomized trials on the effectiveness of computer-tailored education on physical activity and dietary behaviors', 'Placeholder abstract for sample data.', 'Seunguk Yu', @alice, '/uploads/sample_paper_693.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Simon, Herbert A.', 'Placeholder abstract for sample data.', 'Kristian Lum', @seunguk, '/uploads/sample_paper_694.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Cellular automata machines - a new environment for modeling', 'Placeholder abstract for sample data.', 'Jingheng Ye', @jacy, '/uploads/sample_paper_695.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Multimodal Emotion Recognition using Deep Learning', 'Placeholder abstract for sample data.', 'Cara Chen', @ziyang, '/uploads/sample_paper_696.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Information Sciences', 'Placeholder abstract for sample data.', 'Haokun Liu', @zhouhong, '/uploads/sample_paper_697.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Hypergraph Theory: An Introduction', 'Placeholder abstract for sample data.', 'Alice Anderson', @ermo, '/uploads/sample_paper_698.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('What is coordination theory and how can it help design cooperative work systems?', 'Placeholder abstract for sample data.', 'Aaron Nicolson', @hongzhan, '/uploads/sample_paper_699.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Auditory Icons: Using Sound in Computer Interfaces', 'Placeholder abstract for sample data.', 'Srishti Gureja', @seunguk, '/uploads/sample_paper_700.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Auditory Icons: Using Sound in Computer Interfaces', 'Placeholder abstract for sample data.', 'Weiqi Wang', @jacy, '/uploads/sample_paper_701.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Computation and Computational Thinking', 'Placeholder abstract for sample data.', 'Cara Chen', @xinwei, '/uploads/sample_paper_702.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Algebraic theory of processes', 'Placeholder abstract for sample data.', 'Bo Pan', @loic, '/uploads/sample_paper_703.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('OF TECHNOLOGY', 'Placeholder abstract for sample data.', 'Haokun Liu', @ziyang, '/uploads/sample_paper_704.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Computational Thinking, Between Papert and Wing', 'Placeholder abstract for sample data.', 'Bo Pan', @srishti, '/uploads/sample_paper_705.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('HCI Models, Theories, and Frameworks: Toward a Multidisciplinary Science', 'Placeholder abstract for sample data.', 'Dosung Lee', @seunguk, '/uploads/sample_paper_706.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Extending Ourselves: Computational Science, Empiricism, and Scientific Method', 'Placeholder abstract for sample data.', 'Weiqi Wang', @loic, '/uploads/sample_paper_707.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Hybrid Systems: Computation and Control', 'Placeholder abstract for sample data.', 'Yin Cai', @weiqi, '/uploads/sample_paper_708.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('The Grid: A New Infrastructure for 21st Century Science', 'Placeholder abstract for sample data.', 'Cara Chen', @zhouhong, '/uploads/sample_paper_709.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Designing Interaction: Psychology at the Human-Computer Interface', 'Placeholder abstract for sample data.', 'Jacy Reese Anthis', @zhouhong, '/uploads/sample_paper_710.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Specifying computer-supported collaboration scripts', 'Placeholder abstract for sample data.', 'Dosung Lee', @alice, '/uploads/sample_paper_711.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Computing as a discipline', 'Placeholder abstract for sample data.', 'Xinwei Yang', @loic, '/uploads/sample_paper_712.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Computational Geometry', 'Placeholder abstract for sample data.', 'Weiqi Wang', @cara, '/uploads/sample_paper_713.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Realization of a scalable Shor algorithm', 'Placeholder abstract for sample data.', 'Wenhan Liu', @loic, '/uploads/sample_paper_714.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Should Computer Scientists Experiment More?', 'Placeholder abstract for sample data.', 'Kristian Lum', @weiqi, '/uploads/sample_paper_715.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Concurrent Programming In Java', 'Placeholder abstract for sample data.', 'Ermo Hua', @hongzhan, '/uploads/sample_paper_716.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Auctions and bidding: A guide for computer scientists', 'Placeholder abstract for sample data.', 'Srishti Gureja', @dosung, '/uploads/sample_paper_717.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('A neural algorithm for a fundamental computing problem', 'Placeholder abstract for sample data.', 'Loic Fosse', @ermo, '/uploads/sample_paper_718.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('A New Feedback Method for Dynamic Control of Manipulators', 'Placeholder abstract for sample data.', 'Bo Pan', @weiqi, '/uploads/sample_paper_719.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Distributed Systems: Concepts and Design', 'Placeholder abstract for sample data.', 'Bo Pan', @aaron, '/uploads/sample_paper_720.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('How to build and use agent-based models in social science', 'Placeholder abstract for sample data.', 'Junlin Li', @zhouhong, '/uploads/sample_paper_721.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Probability and Computing', 'Placeholder abstract for sample data.', 'Wenhan Liu', @junlin, '/uploads/sample_paper_722.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('The Open Science Grid', 'Placeholder abstract for sample data.', 'Cara Chen', @junlin, '/uploads/sample_paper_723.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Tools for Thinking—Modelling in Management Science', 'Placeholder abstract for sample data.', 'Kristian Lum', @hongzhan, '/uploads/sample_paper_724.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Cellular Automata Machines', 'Placeholder abstract for sample data.', 'Kristian Lum', @jingheng, '/uploads/sample_paper_725.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('The philosophical novelty of computer simulation methods', 'Placeholder abstract for sample data.', 'Bo Pan', @seunguk, '/uploads/sample_paper_726.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Numerical analysis: mathematics of scientific computing (2nd ed)', 'Placeholder abstract for sample data.', 'Cara Chen', @wenhan, '/uploads/sample_paper_727.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Ontology learning and population from text - algorithms, evaluation and applications', 'Placeholder abstract for sample data.', 'Haokun Liu', @aaron, '/uploads/sample_paper_728.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('The Problem with Determining Atomic Structure at the Nanoscale', 'Placeholder abstract for sample data.', 'Hongzhan Lin', @cara, '/uploads/sample_paper_729.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('An Interdisciplinary Perspective on IT Services Management and Service Science', 'Placeholder abstract for sample data.', 'Bo Pan', @alice, '/uploads/sample_paper_730.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Inductive Inference: Theory and Methods', 'Placeholder abstract for sample data.', 'Aaron Nicolson', @zhouhong, '/uploads/sample_paper_731.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Automated identification of media bias in news articles: an interdisciplinary literature review', 'Placeholder abstract for sample data.', 'Seunguk Yu', @jingheng, '/uploads/sample_paper_732.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Artificial Societies: The Computer Simulation of Social Life', 'Placeholder abstract for sample data.', 'Cara Chen', @weiqi, '/uploads/sample_paper_733.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Activity theory and human-computer interaction', 'Placeholder abstract for sample data.', 'Junlin Li', @seunguk, '/uploads/sample_paper_734.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('The Mars Science Laboratory Engineering Cameras', 'Placeholder abstract for sample data.', 'Alice Anderson', @xinwei, '/uploads/sample_paper_735.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Contemporary Cryptology: The Science of Information Integrity', 'Placeholder abstract for sample data.', 'Jacy Reese Anthis', @yin, '/uploads/sample_paper_736.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Stochastic modelling and analysis: a computational approach', 'Placeholder abstract for sample data.', 'Weiqi Wang', @loic, '/uploads/sample_paper_737.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Examining the Challenges of Scientific Workflows', 'Placeholder abstract for sample data.', 'Loic Fosse', @yin, '/uploads/sample_paper_738.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Combinatorial species and tree-like structures', 'Placeholder abstract for sample data.', 'Loic Fosse', @junlin, '/uploads/sample_paper_739.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Twenty Lectures on Algorithmic Game Theory', 'Placeholder abstract for sample data.', 'Ziyang Luo', @ziyang, '/uploads/sample_paper_740.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Trends in cognitive sciences', 'Placeholder abstract for sample data.', 'Loic Fosse', @xinwei, '/uploads/sample_paper_741.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('ACT-R: A cognitive architecture for modeling cognition.', 'Placeholder abstract for sample data.', 'Jingheng Ye', @srishti, '/uploads/sample_paper_742.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Geometric Fundamentals of Robotics', 'Placeholder abstract for sample data.', 'Ziyang Luo', @junlin, '/uploads/sample_paper_743.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Unlocking the clubhouse: women in computing', 'Placeholder abstract for sample data.', 'Zhouhong Gu', @cara, '/uploads/sample_paper_744.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Scratch for budding computer scientists', 'Placeholder abstract for sample data.', 'Zhouhong Gu', @xinwei, '/uploads/sample_paper_745.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('The iPlant Collaborative: Cyberinfrastructure for Plant Biology', 'Placeholder abstract for sample data.', 'Yin Cai', @xinwei, '/uploads/sample_paper_746.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Principles of Robot Motion: Theory, Algorithms, and Implementations', 'Placeholder abstract for sample data.', 'Wenhan Liu', @junlin, '/uploads/sample_paper_747.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Towards Large-Scale Quantum Networks', 'Placeholder abstract for sample data.', 'Dosung Lee', @ermo, '/uploads/sample_paper_748.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('CS Unplugged - How Is It Used, and Does It Work?', 'Placeholder abstract for sample data.', 'Kristian Lum', @zhouhong, '/uploads/sample_paper_749.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Density of states prediction for materials discovery via contrastive learning from probabilistic embeddings', 'Placeholder abstract for sample data.', 'Wenhan Liu', @zhouhong, '/uploads/sample_paper_750.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('A simple algorithm for homeomorphic surface reconstruction', 'Placeholder abstract for sample data.', 'Ermo Hua', @yin, '/uploads/sample_paper_751.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Do Female and Male Role Models Who Embody STEM Stereotypes Hinder Women’s Anticipated Success in STEM?', 'Placeholder abstract for sample data.', 'Loic Fosse', @kristian, '/uploads/sample_paper_752.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Lectures in Game Theory for Computer Scientists', 'Placeholder abstract for sample data.', 'Seunguk Yu', @alice, '/uploads/sample_paper_753.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Quantum Computing for Computer Scientists', 'Placeholder abstract for sample data.', 'Jingheng Ye', @yin, '/uploads/sample_paper_754.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Negative Probability', 'Placeholder abstract for sample data.', 'Alice Anderson', @jacy, '/uploads/sample_paper_755.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Molecular Weight Dependence of Polymersome Membrane Structure, Elasticity, and Stability', 'Placeholder abstract for sample data.', 'Aaron Nicolson', @weiqi, '/uploads/sample_paper_756.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Computational Modeling, Formal Analysis, and Tools for Systems Biology', 'Placeholder abstract for sample data.', 'Yin Cai', @srishti, '/uploads/sample_paper_757.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Robot Control: The Task Function Approach', 'Placeholder abstract for sample data.', 'Haokun Liu', @xinwei, '/uploads/sample_paper_758.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('DBLP - Some Lessons Learned', 'Placeholder abstract for sample data.', 'Jingheng Ye', @jacy, '/uploads/sample_paper_759.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('The fairy performance assessment: measuring computational thinking in middle school', 'Placeholder abstract for sample data.', 'Loic Fosse', @cara, '/uploads/sample_paper_760.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Artificial Intelligence and its Application in Different Areas', 'Placeholder abstract for sample data.', 'Dosung Lee', @junlin, '/uploads/sample_paper_761.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Turtle geometry : the computer as a medium for exploring mathematics', 'Placeholder abstract for sample data.', 'Srishti Gureja', @loic, '/uploads/sample_paper_762.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('On the Computational Complexity of Algorithms', 'Placeholder abstract for sample data.', 'Haokun Liu', @ermo, '/uploads/sample_paper_763.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Introduction to High Performance Computing for Scientists and Engineers', 'Placeholder abstract for sample data.', 'Ziyang Luo', @zhouhong, '/uploads/sample_paper_764.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Biomolecules in the computer: Jmol to the rescue', 'Placeholder abstract for sample data.', 'Junlin Li', @weiqi, '/uploads/sample_paper_765.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('The Nature of Computation', 'Placeholder abstract for sample data.', 'Haokun Liu', @yin, '/uploads/sample_paper_766.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Quantum Computing since Democritus', 'Placeholder abstract for sample data.', 'Kristian Lum', @weiqi, '/uploads/sample_paper_767.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Algorithm design', 'Placeholder abstract for sample data.', 'Haokun Liu', @ermo, '/uploads/sample_paper_768.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Handbook of satisfiability', 'Placeholder abstract for sample data.', 'Weiqi Wang', @jingheng, '/uploads/sample_paper_769.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Computer Performance Modeling Handbook', 'Placeholder abstract for sample data.', 'Jacy Reese Anthis', @jingheng, '/uploads/sample_paper_770.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Computer Security: Principles and Practice', 'Placeholder abstract for sample data.', 'Srishti Gureja', @alice, '/uploads/sample_paper_771.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Computational Thinking', 'Placeholder abstract for sample data.', 'Hongzhan Lin', @yin, '/uploads/sample_paper_772.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('SciNet: Lessons Learned from Building a Power-efficient Top-20 System and Data Centre', 'Placeholder abstract for sample data.', 'Aaron Nicolson', @junlin, '/uploads/sample_paper_773.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('A First Course in Graph Theory', 'Placeholder abstract for sample data.', 'Junlin Li', @srishti, '/uploads/sample_paper_774.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Digital Evidence and Computer Crime', 'Placeholder abstract for sample data.', 'Jingheng Ye', @wenhan, '/uploads/sample_paper_775.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Experimental Models for Validating Technology', 'Placeholder abstract for sample data.', 'Aaron Nicolson', @bo, '/uploads/sample_paper_776.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Quantum computers', 'Placeholder abstract for sample data.', 'Yin Cai', @loic, '/uploads/sample_paper_777.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('An Introduction to Kolmogorov Complexity and Its Applications, Third Edition', 'Placeholder abstract for sample data.', 'Srishti Gureja', @srishti, '/uploads/sample_paper_778.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Elementary Functions', 'Placeholder abstract for sample data.', 'Loic Fosse', @ermo, '/uploads/sample_paper_779.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('An Introduction to Formal Language Theory', 'Placeholder abstract for sample data.', 'Junlin Li', @kristian, '/uploads/sample_paper_780.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Shadows of the Mind: A Search for the Missing Science of Consciousness', 'Placeholder abstract for sample data.', 'Seunguk Yu', @hongzhan, '/uploads/sample_paper_781.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Toward Conversational Human-Computer Interaction', 'Placeholder abstract for sample data.', 'Loic Fosse', @cara, '/uploads/sample_paper_782.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Typologies and taxonomies: An introduction to classification techniques.', 'Placeholder abstract for sample data.', 'Loic Fosse', @weiqi, '/uploads/sample_paper_783.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Principles of Artificial Neural Networks', 'Placeholder abstract for sample data.', 'Hongzhan Lin', @ermo, '/uploads/sample_paper_784.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Introduction to Bisimulation and Coinduction', 'Placeholder abstract for sample data.', 'Cara Chen', @xinwei, '/uploads/sample_paper_785.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Computational molecular biology : an algorithmic approach', 'Placeholder abstract for sample data.', 'Junlin Li', @ermo, '/uploads/sample_paper_786.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('The Age of Social Sensing', 'Placeholder abstract for sample data.', 'Ermo Hua', @srishti, '/uploads/sample_paper_787.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Toward a consensus map of science', 'Placeholder abstract for sample data.', 'Weiqi Wang', @bo, '/uploads/sample_paper_788.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Science Education With English Language Learners: Synthesis and Research Agenda', 'Placeholder abstract for sample data.', 'Xinwei Yang', @haokun, '/uploads/sample_paper_789.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Handbook of Ambient Intelligence and Smart Environments', 'Placeholder abstract for sample data.', 'Loic Fosse', @jingheng, '/uploads/sample_paper_790.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Planning Support Systems: A New Perspective on Computer-Aided Planning', 'Placeholder abstract for sample data.', 'Junlin Li', @srishti, '/uploads/sample_paper_791.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Computing Curricula 2005: The Overview Report', 'Placeholder abstract for sample data.', 'Dosung Lee', @jingheng, '/uploads/sample_paper_792.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('QuickSet: multimodal interaction for distributed applications', 'Placeholder abstract for sample data.', 'Cara Chen', @kristian, '/uploads/sample_paper_793.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('A STUDY ON SCIENCE TEACHERS'' ATTITUDES TOWARD INFORMATION AND COMMUNICATION TECHNOLOGIES IN EDUCATION', 'Placeholder abstract for sample data.', 'Ziyang Luo', @ziyang, '/uploads/sample_paper_794.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Drexel University', 'Placeholder abstract for sample data.', 'Weiqi Wang', @loic, '/uploads/sample_paper_795.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Universal Algebra for Computer Scientists', 'Placeholder abstract for sample data.', 'Ziyang Luo', @seunguk, '/uploads/sample_paper_796.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('A framework to foster problem-solving in STEM and computing education', 'Placeholder abstract for sample data.', 'Alice Anderson', @wenhan, '/uploads/sample_paper_797.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Critical Behavior in the Satisfiability of Random Boolean Expressions', 'Placeholder abstract for sample data.', 'Kristian Lum', @bo, '/uploads/sample_paper_798.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('A Unified Approach to Interior Point Algorithms for Linear Complementarity Problems', 'Placeholder abstract for sample data.', 'Aaron Nicolson', @haokun, '/uploads/sample_paper_799.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Random Oracles Are Practical: a Paradigm for Designing Eecient Protocols', 'Placeholder abstract for sample data.', 'Dosung Lee', @yin, '/uploads/sample_paper_800.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('The Human Use of Human Beings: Cybernetics and Society', 'Placeholder abstract for sample data.', 'Srishti Gureja', @jingheng, '/uploads/sample_paper_801.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('A Review on Machine Learning Algorithms', 'Placeholder abstract for sample data.', 'Wenhan Liu', @weiqi, '/uploads/sample_paper_802.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('The Place of Modeling in Cognitive Science', 'Placeholder abstract for sample data.', 'Bo Pan', @loic, '/uploads/sample_paper_803.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Computer Viruses and Malware', 'Placeholder abstract for sample data.', 'Cara Chen', @hongzhan, '/uploads/sample_paper_804.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Personalized messages that promote science learning in virtual environments', 'Placeholder abstract for sample data.', 'Junlin Li', @bo, '/uploads/sample_paper_805.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Verification of Computer Simulation Models', 'Placeholder abstract for sample data.', 'Zhouhong Gu', @seunguk, '/uploads/sample_paper_806.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Quantum Walks for Computer Scientists', 'Placeholder abstract for sample data.', 'Yin Cai', @yin, '/uploads/sample_paper_807.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Bioinformatics—an introduction for computer scientists', 'Placeholder abstract for sample data.', 'Weiqi Wang', @xinwei, '/uploads/sample_paper_808.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Human-computer interaction: psychological aspects of the human use of computing.', 'Placeholder abstract for sample data.', 'Yin Cai', @dosung, '/uploads/sample_paper_809.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('The Semantic Grid: A Future e‐Science Infrastructure', 'Placeholder abstract for sample data.', 'Bo Pan', @jingheng, '/uploads/sample_paper_810.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Sim: a utility for detecting similarity in computer programs', 'Placeholder abstract for sample data.', 'Jingheng Ye', @yin, '/uploads/sample_paper_811.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Introduction to Biometrics', 'Placeholder abstract for sample data.', 'Loic Fosse', @loic, '/uploads/sample_paper_812.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('A multidisciplinary approach towards computational thinking for science majors', 'Placeholder abstract for sample data.', 'Loic Fosse', @yin, '/uploads/sample_paper_813.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Introduction to Geometry', 'Placeholder abstract for sample data.', 'Alice Anderson', @haokun, '/uploads/sample_paper_814.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Computer programming as an art', 'Placeholder abstract for sample data.', 'Weiqi Wang', @ermo, '/uploads/sample_paper_815.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Design Science I: The Role of Design Science in Electronic Commerce Research', 'Placeholder abstract for sample data.', 'Srishti Gureja', @zhouhong, '/uploads/sample_paper_816.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Introductory Combinatorics', 'Placeholder abstract for sample data.', 'Yin Cai', @yin, '/uploads/sample_paper_817.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('XXII. Programming a Computer for Playing Chess 1', 'Placeholder abstract for sample data.', 'Alice Anderson', @seunguk, '/uploads/sample_paper_818.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('The relationship of computer self-efficacy expectations to computer interest and course enrollment in college', 'Placeholder abstract for sample data.', 'Loic Fosse', @bo, '/uploads/sample_paper_819.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('2020 Computing: Science in an exponential world', 'Placeholder abstract for sample data.', 'Alice Anderson', @ermo, '/uploads/sample_paper_820.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Energy-efficient area monitoring for sensor networks', 'Placeholder abstract for sample data.', 'Wenhan Liu', @cara, '/uploads/sample_paper_821.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Criminalistics: An introduction to forensic science', 'Placeholder abstract for sample data.', 'Weiqi Wang', @hongzhan, '/uploads/sample_paper_822.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('The Psychology of Human-Computer Interaction', 'Placeholder abstract for sample data.', 'Xinwei Yang', @kristian, '/uploads/sample_paper_823.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Thinking about computational thinking', 'Placeholder abstract for sample data.', 'Yin Cai', @alice, '/uploads/sample_paper_824.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Logic Programming and Nonmonotonic Reasoning', 'Placeholder abstract for sample data.', 'Kristian Lum', @aaron, '/uploads/sample_paper_825.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Fieldwork for Design - Theory and Practice', 'Placeholder abstract for sample data.', 'Alice Anderson', @zhouhong, '/uploads/sample_paper_826.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Computer supported cooperative work: The journal of collaborative computing', 'Placeholder abstract for sample data.', 'Hongzhan Lin', @wenhan, '/uploads/sample_paper_827.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Interfacing Thought: Cognitive Aspects of Human-Computer Interaction', 'Placeholder abstract for sample data.', 'Srishti Gureja', @kristian, '/uploads/sample_paper_828.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Effects of Computer Simulations and Problem-Solving Approaches on High School Students', 'Placeholder abstract for sample data.', 'Cara Chen', @haokun, '/uploads/sample_paper_829.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('EducationPaving the way for computational thinking', 'Placeholder abstract for sample data.', 'Jacy Reese Anthis', @ziyang, '/uploads/sample_paper_830.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('White Rose Consortium ePrints Repository', 'Placeholder abstract for sample data.', 'Cara Chen', @seunguk, '/uploads/sample_paper_831.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Why are there so few female computer scientists', 'Placeholder abstract for sample data.', 'Yin Cai', @seunguk, '/uploads/sample_paper_832.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Computer Algebra', 'Placeholder abstract for sample data.', 'Xinwei Yang', @hongzhan, '/uploads/sample_paper_833.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Preprints for the life sciences', 'Placeholder abstract for sample data.', 'Weiqi Wang', @dosung, '/uploads/sample_paper_834.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Analysis of Visual Motion by Biological and Computer Systems', 'Placeholder abstract for sample data.', 'Wenhan Liu', @aaron, '/uploads/sample_paper_835.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Becoming a computer scientist', 'Placeholder abstract for sample data.', 'Ziyang Luo', @dosung, '/uploads/sample_paper_836.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('The Embedded Systems Design Challenge', 'Placeholder abstract for sample data.', 'Ziyang Luo', @yin, '/uploads/sample_paper_837.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Using Upper-Elementary Student Performance to Understand Conceptual Sequencing in a Blocks-based Curriculum', 'Placeholder abstract for sample data.', 'Bo Pan', @seunguk, '/uploads/sample_paper_838.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('The Computer Age: A Twenty-Year View', 'Placeholder abstract for sample data.', 'Zhouhong Gu', @bo, '/uploads/sample_paper_839.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Community Structure in Graphs', 'Placeholder abstract for sample data.', 'Haokun Liu', @aaron, '/uploads/sample_paper_840.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Cognitive Science: The Newest Science of the Artificial', 'Placeholder abstract for sample data.', 'Bo Pan', @dosung, '/uploads/sample_paper_841.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Quantum Hamiltonian Complexity', 'Placeholder abstract for sample data.', 'Bo Pan', @xinwei, '/uploads/sample_paper_842.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('The verifying compiler: A grand challenge for computing research', 'Placeholder abstract for sample data.', 'Alice Anderson', @jacy, '/uploads/sample_paper_843.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('A Personal Computer for Children of All Ages', 'Placeholder abstract for sample data.', 'Jingheng Ye', @junlin, '/uploads/sample_paper_844.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Software-Realized Scaffolding to Facilitate Programming for Science Learning', 'Placeholder abstract for sample data.', 'Yin Cai', @hongzhan, '/uploads/sample_paper_845.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Probability in the Engineering and Informational Sciences', 'Placeholder abstract for sample data.', 'Wenhan Liu', @junlin, '/uploads/sample_paper_846.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Computer Simulation in the Physical Sciences', 'Placeholder abstract for sample data.', 'Jacy Reese Anthis', @seunguk, '/uploads/sample_paper_847.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Introduction to Management Science', 'Placeholder abstract for sample data.', 'Junlin Li', @junlin, '/uploads/sample_paper_848.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Collaboratories: Doing Science on the Internet', 'Placeholder abstract for sample data.', 'Weiqi Wang', @aaron, '/uploads/sample_paper_849.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Fractals in Science', 'Placeholder abstract for sample data.', 'Hongzhan Lin', @dosung, '/uploads/sample_paper_850.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('"Science Citation Index"--A New Dimension in Indexing.', 'Placeholder abstract for sample data.', 'Seunguk Yu', @ermo, '/uploads/sample_paper_851.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('TeraGrid Science Gateways and Their Impact on Science', 'Placeholder abstract for sample data.', 'Junlin Li', @loic, '/uploads/sample_paper_852.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Numerical Methods For Mathematics, Science, and Engineering', 'Placeholder abstract for sample data.', 'Haokun Liu', @seunguk, '/uploads/sample_paper_853.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Improving the CS1 experience with pair programming', 'Placeholder abstract for sample data.', 'Dosung Lee', @zhouhong, '/uploads/sample_paper_854.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Journal of chemical information and computer sciences.', 'Placeholder abstract for sample data.', 'Haokun Liu', @alice, '/uploads/sample_paper_855.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('The Closed World: Computers and the Politics of Discourse in Cold War America', 'Placeholder abstract for sample data.', 'Bo Pan', @cara, '/uploads/sample_paper_856.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Selected climatic data for a global set of standard stations for vegetation science', 'Placeholder abstract for sample data.', 'Hongzhan Lin', @jingheng, '/uploads/sample_paper_857.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('A Logical Approach to Discrete Math', 'Placeholder abstract for sample data.', 'Ermo Hua', @weiqi, '/uploads/sample_paper_858.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Numerical Methods For Mathematics, Science, and Engineering', 'Placeholder abstract for sample data.', 'Weiqi Wang', @jingheng, '/uploads/sample_paper_859.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Explaining Underrepresentation: A Theory of Precluded Interest', 'Placeholder abstract for sample data.', 'Bo Pan', @srishti, '/uploads/sample_paper_860.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('MOCHA: Modularity in Model Checking', 'Placeholder abstract for sample data.', 'Alice Anderson', @loic, '/uploads/sample_paper_861.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('The Seven Beauties of Science Fiction', 'Placeholder abstract for sample data.', 'Ziyang Luo', @srishti, '/uploads/sample_paper_862.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Computers in teaching science: To simulate or not to simulate?', 'Placeholder abstract for sample data.', 'Junlin Li', @zhouhong, '/uploads/sample_paper_863.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('The garden in the machine: the emerging science of artificial life', 'Placeholder abstract for sample data.', 'Kristian Lum', @dosung, '/uploads/sample_paper_864.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Parsing Techniques - A Practical Guide', 'Placeholder abstract for sample data.', 'Weiqi Wang', @xinwei, '/uploads/sample_paper_865.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Unlocking the clubhouse: the Carnegie Mellon experience', 'Placeholder abstract for sample data.', 'Hongzhan Lin', @jingheng, '/uploads/sample_paper_866.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Toward More Gender Diversity in CS through an Artificial Intelligence Summer Program for High School Girls', 'Placeholder abstract for sample data.', 'Seunguk Yu', @ermo, '/uploads/sample_paper_867.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Noise stability of functions with low influences: Invariance and optimality', 'Placeholder abstract for sample data.', 'Junlin Li', @seunguk, '/uploads/sample_paper_868.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('A Short Introduction to Computational Social Choice', 'Placeholder abstract for sample data.', 'Haokun Liu', @yin, '/uploads/sample_paper_869.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Models of Computation: Exploring the Power of Computing', 'Placeholder abstract for sample data.', 'Yin Cai', @alice, '/uploads/sample_paper_870.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Computational composites', 'Placeholder abstract for sample data.', 'Loic Fosse', @bo, '/uploads/sample_paper_871.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('High performance computing in science and engineering', 'Placeholder abstract for sample data.', 'Srishti Gureja', @wenhan, '/uploads/sample_paper_872.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Logic Programming and Databases', 'Placeholder abstract for sample data.', 'Ermo Hua', @zhouhong, '/uploads/sample_paper_873.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Computer and Information Sciences', 'Placeholder abstract for sample data.', 'Seunguk Yu', @jacy, '/uploads/sample_paper_874.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Subgoal-labeled instructional material improves performance and transfer in learning to develop mobile applications', 'Placeholder abstract for sample data.', 'Zhouhong Gu', @alice, '/uploads/sample_paper_875.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Information Flow: The Logic of Distributed Systems', 'Placeholder abstract for sample data.', 'Seunguk Yu', @weiqi, '/uploads/sample_paper_876.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Habits of programming in scratch', 'Placeholder abstract for sample data.', 'Jingheng Ye', @xinwei, '/uploads/sample_paper_877.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Debugging: a review of the literature from an educational perspective', 'Placeholder abstract for sample data.', 'Wenhan Liu', @bo, '/uploads/sample_paper_878.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Genetic and evolutionary algorithms come of age', 'Placeholder abstract for sample data.', 'Wenhan Liu', @junlin, '/uploads/sample_paper_879.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Documents', 'Placeholder abstract for sample data.', 'Cara Chen', @zhouhong, '/uploads/sample_paper_880.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Storage and Retrieval', 'Placeholder abstract for sample data.', 'Ermo Hua', @junlin, '/uploads/sample_paper_881.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Affordances and Constraints of Computers in Science Education', 'Placeholder abstract for sample data.', 'Weiqi Wang', @yin, '/uploads/sample_paper_882.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Alignment', 'Placeholder abstract for sample data.', 'Jacy Reese Anthis', @xinwei, '/uploads/sample_paper_883.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Statistical Analysis of Extreme Values', 'Placeholder abstract for sample data.', 'Junlin Li', @alice, '/uploads/sample_paper_884.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Evaluating the effectiveness of a new instructional approach', 'Placeholder abstract for sample data.', 'Alice Anderson', @junlin, '/uploads/sample_paper_885.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('An architecture for integrating plan-based behavior generation with interactive game environments', 'Placeholder abstract for sample data.', 'Jacy Reese Anthis', @zhouhong, '/uploads/sample_paper_886.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('On the origins of bisimulation and coinduction', 'Placeholder abstract for sample data.', 'Yin Cai', @haokun, '/uploads/sample_paper_887.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Empowering All Students: Closing the CS Confidence Gap with an In-School Initiative for Middle School Students', 'Placeholder abstract for sample data.', 'Zhouhong Gu', @loic, '/uploads/sample_paper_888.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Quantum computing', 'Placeholder abstract for sample data.', 'Hongzhan Lin', @ermo, '/uploads/sample_paper_889.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('The CS principles project', 'Placeholder abstract for sample data.', 'Haokun Liu', @haokun, '/uploads/sample_paper_890.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('The impact of pair programming on student performance, perception and persistence', 'Placeholder abstract for sample data.', 'Alice Anderson', @ziyang, '/uploads/sample_paper_891.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Automated Reasoning with Analytic Tableaux and Related Methods', 'Placeholder abstract for sample data.', 'Jacy Reese Anthis', @jacy, '/uploads/sample_paper_892.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('The many facets of natural computing', 'Placeholder abstract for sample data.', 'Seunguk Yu', @zhouhong, '/uploads/sample_paper_893.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Cellular abstractions: Cells as computation', 'Placeholder abstract for sample data.', 'Bo Pan', @junlin, '/uploads/sample_paper_894.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Applied and algorithmic graph theory', 'Placeholder abstract for sample data.', 'Ermo Hua', @xinwei, '/uploads/sample_paper_895.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Molecular and Cellular Approaches to Memory Allocation in Neural Circuits', 'Placeholder abstract for sample data.', 'Cara Chen', @loic, '/uploads/sample_paper_896.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Blackwell Guide to the Philosophy of Computing and Information', 'Placeholder abstract for sample data.', 'Jacy Reese Anthis', @weiqi, '/uploads/sample_paper_897.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Ruby: The Programming Language', 'Placeholder abstract for sample data.', 'Srishti Gureja', @wenhan, '/uploads/sample_paper_898.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Use of Sequential Bayesian Model in Diagnosis of Jaundice by Computer', 'Placeholder abstract for sample data.', 'Dosung Lee', @ermo, '/uploads/sample_paper_899.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('A system for algorithm animation', 'Placeholder abstract for sample data.', 'Wenhan Liu', @kristian, '/uploads/sample_paper_900.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Relations and Graphs', 'Placeholder abstract for sample data.', 'Cara Chen', @yin, '/uploads/sample_paper_901.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('The computational complexity of algebraic and numeric problems', 'Placeholder abstract for sample data.', 'Cara Chen', @ziyang, '/uploads/sample_paper_902.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('A Blueprint for Affective Computing: A Sourcebook and Manual', 'Placeholder abstract for sample data.', 'Yin Cai', @cara, '/uploads/sample_paper_903.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Beyond Calculation', 'Placeholder abstract for sample data.', 'Hongzhan Lin', @kristian, '/uploads/sample_paper_904.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Does contextualized computing education help?', 'Placeholder abstract for sample data.', 'Weiqi Wang', @xinwei, '/uploads/sample_paper_905.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Benchmark Generator for CEC''2009 Competition on Dynamic Optimization', 'Placeholder abstract for sample data.', 'Junlin Li', @ziyang, '/uploads/sample_paper_906.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('JFP volume 2 issue 1 Cover and Back matter', 'Placeholder abstract for sample data.', 'Yin Cai', @cara, '/uploads/sample_paper_907.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Derived Categories of Twisted Sheaves on Calabi-Yau Manifolds', 'Placeholder abstract for sample data.', 'Dosung Lee', @cara, '/uploads/sample_paper_908.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('On plugging "unplugged" into CS classes', 'Placeholder abstract for sample data.', 'Kristian Lum', @wenhan, '/uploads/sample_paper_909.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Expert Systems Research.', 'Placeholder abstract for sample data.', 'Ziyang Luo', @jingheng, '/uploads/sample_paper_910.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Local Structure in Social Networks', 'Placeholder abstract for sample data.', 'Seunguk Yu', @ermo, '/uploads/sample_paper_911.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Book Review: Computerization and Controversy: Value Conflicts and Social Choices', 'Placeholder abstract for sample data.', 'Yin Cai', @jacy, '/uploads/sample_paper_912.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Beyond Productivity: Information, Technology, Innovation, and Creativity', 'Placeholder abstract for sample data.', 'Weiqi Wang', @zhouhong, '/uploads/sample_paper_913.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Computing Curricula 1991', 'Placeholder abstract for sample data.', 'Ermo Hua', @wenhan, '/uploads/sample_paper_914.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Women and computing', 'Placeholder abstract for sample data.', 'Alice Anderson', @seunguk, '/uploads/sample_paper_915.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Software Development and Reality Construction', 'Placeholder abstract for sample data.', 'Dosung Lee', @jingheng, '/uploads/sample_paper_916.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Term rewriting systems', 'Placeholder abstract for sample data.', 'Hongzhan Lin', @xinwei, '/uploads/sample_paper_917.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('25 Years of Model Checking - History, Achievements, Perspectives', 'Placeholder abstract for sample data.', 'Hongzhan Lin', @yin, '/uploads/sample_paper_918.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('The Discipline of Embedded Systems Design', 'Placeholder abstract for sample data.', 'Weiqi Wang', @alice, '/uploads/sample_paper_919.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('In support of student pair-programming', 'Placeholder abstract for sample data.', 'Junlin Li', @jingheng, '/uploads/sample_paper_920.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('A CS1 course designed to address interests of women', 'Placeholder abstract for sample data.', 'Jacy Reese Anthis', @jingheng, '/uploads/sample_paper_921.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Conceptual Structures: Logical, Linguistic, and Computational Issues', 'Placeholder abstract for sample data.', 'Wenhan Liu', @loic, '/uploads/sample_paper_922.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Teaching HCI Design With the Studio Approach', 'Placeholder abstract for sample data.', 'Zhouhong Gu', @junlin, '/uploads/sample_paper_923.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Relationships and tasks in scientific research collaborations', 'Placeholder abstract for sample data.', 'Seunguk Yu', @loic, '/uploads/sample_paper_924.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Documents', 'Placeholder abstract for sample data.', 'Cara Chen', @junlin, '/uploads/sample_paper_925.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Real time design and animation of fractal plants and trees', 'Placeholder abstract for sample data.', 'Jacy Reese Anthis', @seunguk, '/uploads/sample_paper_926.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Advances in Production Management Systems', 'Placeholder abstract for sample data.', 'Hongzhan Lin', @dosung, '/uploads/sample_paper_927.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Women in CS: an evaluation of three promising practices', 'Placeholder abstract for sample data.', 'Ermo Hua', @ermo, '/uploads/sample_paper_928.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Influence of the familiarization with "scratch" on future teachers'' opinions and attitudes about programming and ICT in education', 'Placeholder abstract for sample data.', 'Cara Chen', @weiqi, '/uploads/sample_paper_929.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Computers and education', 'Placeholder abstract for sample data.', 'Junlin Li', @aaron, '/uploads/sample_paper_930.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Sanctioning Models: The Epistemology of Simulation', 'Placeholder abstract for sample data.', 'Junlin Li', @jacy, '/uploads/sample_paper_931.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Teaching software engineering through game design', 'Placeholder abstract for sample data.', 'Bo Pan', @ziyang, '/uploads/sample_paper_932.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('A topological approach to digital topology', 'Placeholder abstract for sample data.', 'Jacy Reese Anthis', @jingheng, '/uploads/sample_paper_933.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('On Kleene Algebras and Closed Semirings', 'Placeholder abstract for sample data.', 'Jingheng Ye', @jingheng, '/uploads/sample_paper_934.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Games as a "flavor" of CS1', 'Placeholder abstract for sample data.', 'Jacy Reese Anthis', @wenhan, '/uploads/sample_paper_935.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('The role of physicality in rich programming environments', 'Placeholder abstract for sample data.', 'Hongzhan Lin', @yin, '/uploads/sample_paper_936.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('MARS: an education-oriented MIPS assembly language simulator', 'Placeholder abstract for sample data.', 'Ziyang Luo', @aaron, '/uploads/sample_paper_937.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('A Cyberfeminist Utopia?', 'Placeholder abstract for sample data.', 'Junlin Li', @weiqi, '/uploads/sample_paper_938.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Computational challenges of systems biology', 'Placeholder abstract for sample data.', 'Aaron Nicolson', @yin, '/uploads/sample_paper_939.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Algebraic semantics', 'Placeholder abstract for sample data.', 'Jacy Reese Anthis', @zhouhong, '/uploads/sample_paper_940.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Abstract interpretation: a semantics-based tool for program analysis', 'Placeholder abstract for sample data.', 'Cara Chen', @haokun, '/uploads/sample_paper_941.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Trees and proximity representations', 'Placeholder abstract for sample data.', 'Ziyang Luo', @haokun, '/uploads/sample_paper_942.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Review: A Primer on Aspects of Cognition for Medical Informatics', 'Placeholder abstract for sample data.', 'Junlin Li', @kristian, '/uploads/sample_paper_943.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Socially relevant computing', 'Placeholder abstract for sample data.', 'Alice Anderson', @dosung, '/uploads/sample_paper_944.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('1999 Annual Report', 'Placeholder abstract for sample data.', 'Hongzhan Lin', @weiqi, '/uploads/sample_paper_945.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('States of consciousness and state-specific sciences.', 'Placeholder abstract for sample data.', 'Hongzhan Lin', @haokun, '/uploads/sample_paper_946.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('The Information Systems Research Cycle', 'Placeholder abstract for sample data.', 'Ermo Hua', @ermo, '/uploads/sample_paper_947.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Embodied Artificial Intelligence', 'Placeholder abstract for sample data.', 'Seunguk Yu', @wenhan, '/uploads/sample_paper_948.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Verified software: a grand challenge', 'Placeholder abstract for sample data.', 'Junlin Li', @srishti, '/uploads/sample_paper_949.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('The Effects of Wireless Computing in Collaborative Learning Environments', 'Placeholder abstract for sample data.', 'Jingheng Ye', @alice, '/uploads/sample_paper_950.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Distributed Quantum Computing', 'Placeholder abstract for sample data.', 'Kristian Lum', @hongzhan, '/uploads/sample_paper_951.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Algorithmics: The Spirit of Computing', 'Placeholder abstract for sample data.', 'Alice Anderson', @alice, '/uploads/sample_paper_952.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Education for computing professionals', 'Placeholder abstract for sample data.', 'Haokun Liu', @weiqi, '/uploads/sample_paper_953.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('A Rejoinder', 'Placeholder abstract for sample data.', 'Bo Pan', @junlin, '/uploads/sample_paper_954.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Caring about connections: gender and computing', 'Placeholder abstract for sample data.', 'Zhouhong Gu', @cara, '/uploads/sample_paper_955.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('The CS10K project: mobilizing the community to transform high school computing', 'Placeholder abstract for sample data.', 'Weiqi Wang', @seunguk, '/uploads/sample_paper_956.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Testing On Computers', 'Placeholder abstract for sample data.', 'Bo Pan', @kristian, '/uploads/sample_paper_957.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('What (else) should CS educators know?', 'Placeholder abstract for sample data.', 'Srishti Gureja', @zhouhong, '/uploads/sample_paper_958.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Design patterns: an essential component of CS curricula', 'Placeholder abstract for sample data.', 'Junlin Li', @jacy, '/uploads/sample_paper_959.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Mathematical theory of domains', 'Placeholder abstract for sample data.', 'Wenhan Liu', @cara, '/uploads/sample_paper_960.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Note to self: make assignments meaningful', 'Placeholder abstract for sample data.', 'Weiqi Wang', @seunguk, '/uploads/sample_paper_961.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Conceptual Structures: Integration and Interfaces', 'Placeholder abstract for sample data.', 'Xinwei Yang', @seunguk, '/uploads/sample_paper_962.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Interactive visualization for the active learning classroom', 'Placeholder abstract for sample data.', 'Jingheng Ye', @jacy, '/uploads/sample_paper_963.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('SYSTEM DESIGN DOCUMENT: NEXT-GENERATION INTRUSION DETECTION EXPERT SYSTEM (NIDES)', 'Placeholder abstract for sample data.', 'Aaron Nicolson', @ziyang, '/uploads/sample_paper_964.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Scaling up: a research agenda for software engineering', 'Placeholder abstract for sample data.', 'Kristian Lum', @junlin, '/uploads/sample_paper_965.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('A model for improving secondary CS education', 'Placeholder abstract for sample data.', 'Weiqi Wang', @ziyang, '/uploads/sample_paper_966.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Multilevel sensitive reconstruction of polyhedral surfaces from parallel slices', 'Placeholder abstract for sample data.', 'Wenhan Liu', @zhouhong, '/uploads/sample_paper_967.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Journal of Computer and System Sciences', 'Placeholder abstract for sample data.', 'Dosung Lee', @xinwei, '/uploads/sample_paper_968.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Interaction Design: Beyond Human-Computer Interaction', 'Placeholder abstract for sample data.', 'Wenhan Liu', @kristian, '/uploads/sample_paper_969.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Computer methods for ordinary differential equations and differential-algebraic equations', 'Placeholder abstract for sample data.', 'Zhouhong Gu', @seunguk, '/uploads/sample_paper_970.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Journal of Computer and System Sciences', 'Placeholder abstract for sample data.', 'Haokun Liu', @weiqi, '/uploads/sample_paper_971.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('UCI Machine Learning Repository, University of California, Irvine, School of Information and Computer Sciences', 'Placeholder abstract for sample data.', 'Hongzhan Lin', @ziyang, '/uploads/sample_paper_972.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('The mangle of practice : time, agency, and science', 'Placeholder abstract for sample data.', 'Weiqi Wang', @aaron, '/uploads/sample_paper_973.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Computer-Supported Collaborative Learning.', 'Placeholder abstract for sample data.', 'Alice Anderson', @seunguk, '/uploads/sample_paper_974.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Chaos, Making a New Science', 'Placeholder abstract for sample data.', 'Jingheng Ye', @ermo, '/uploads/sample_paper_975.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Computer-aided multivariate analysis', 'Placeholder abstract for sample data.', 'Hongzhan Lin', @seunguk, '/uploads/sample_paper_976.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Computer-supported collaborative learning: An historical perspective', 'Placeholder abstract for sample data.', 'Junlin Li', @ziyang, '/uploads/sample_paper_977.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Parallel Computer Architecture: A Hardware/Software Approach', 'Placeholder abstract for sample data.', 'Ziyang Luo', @yin, '/uploads/sample_paper_978.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('The Large High Altitude Air Shower Observatory (LHAASO) Science White Paper', 'Placeholder abstract for sample data.', 'Kristian Lum', @junlin, '/uploads/sample_paper_979.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Establishing and maintaining long-term human-computer relationships', 'Placeholder abstract for sample data.', 'Ermo Hua', @haokun, '/uploads/sample_paper_980.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Euclid. I. Overview of the Euclid mission', 'Placeholder abstract for sample data.', 'Aaron Nicolson', @yin, '/uploads/sample_paper_981.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Data science and prediction', 'Placeholder abstract for sample data.', 'Alice Anderson', @aaron, '/uploads/sample_paper_982.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Interaction Design - Beyond Human-Computer Interaction, 3rd Edition', 'Placeholder abstract for sample data.', 'Ziyang Luo', @hongzhan, '/uploads/sample_paper_983.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('International handbook of science education', 'Placeholder abstract for sample data.', 'Alice Anderson', @yin, '/uploads/sample_paper_984.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Secure Computer Systems : Mathematical Foundations', 'Placeholder abstract for sample data.', 'Alice Anderson', @ermo, '/uploads/sample_paper_985.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('The dynamical hypothesis in cognitive science', 'Placeholder abstract for sample data.', 'Cara Chen', @ziyang, '/uploads/sample_paper_986.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Foundations for a New Science of Learning', 'Placeholder abstract for sample data.', 'Yin Cai', @srishti, '/uploads/sample_paper_987.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Geometric Deep Learning: Going beyond Euclidean data', 'Placeholder abstract for sample data.', 'Ermo Hua', @seunguk, '/uploads/sample_paper_988.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Object recognition by computer - the role of geometric constraints', 'Placeholder abstract for sample data.', 'Dosung Lee', @jacy, '/uploads/sample_paper_989.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Quantum computational advantage using photons', 'Placeholder abstract for sample data.', 'Loic Fosse', @kristian, '/uploads/sample_paper_990.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Urban Computing: Concepts, Methodologies, and Applications', 'Placeholder abstract for sample data.', 'Dosung Lee', @junlin, '/uploads/sample_paper_991.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Quantum internet: A vision for the road ahead', 'Placeholder abstract for sample data.', 'Aaron Nicolson', @aaron, '/uploads/sample_paper_992.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Outlier Analysis', 'Placeholder abstract for sample data.', 'Wenhan Liu', @xinwei, '/uploads/sample_paper_993.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Remington''s pharmaceutical sciences', 'Placeholder abstract for sample data.', 'Cara Chen', @zhouhong, '/uploads/sample_paper_994.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Pre-Service Teachers'' Attitudes towards Computer Use: A Singapore Survey.', 'Placeholder abstract for sample data.', 'Xinwei Yang', @wenhan, '/uploads/sample_paper_995.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Materials challenges and opportunities for quantum computing hardware', 'Placeholder abstract for sample data.', 'Srishti Gureja', @aaron, '/uploads/sample_paper_996.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Surrogates: Gaussian process modeling, design, and optimization for the applied sciences', 'Placeholder abstract for sample data.', 'Wenhan Liu', @loic, '/uploads/sample_paper_997.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('G*Power 3: A flexible statistical power analysis program for the social, behavioral, and biomedical sciences', 'Placeholder abstract for sample data.', 'Kristian Lum', @ziyang, '/uploads/sample_paper_998.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Qualitative Data Analysis with NVivo', 'Placeholder abstract for sample data.', 'Hongzhan Lin', @alice, '/uploads/sample_paper_999.pdf');

INSERT INTO paper (title, abstract, authors, uploaderId, filePath) VALUES
('Modularity and community structure in networks.', 'Placeholder abstract for sample data.', 'Haokun Liu', @loic, '/uploads/sample_paper_1000.pdf');





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
