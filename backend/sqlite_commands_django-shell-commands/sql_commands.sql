-- SQLite truncate table
DELETE FROM product_feed_generator_serverkast_product;


-- SQLite 
UPDATE feedback_feedback
SET created_at = '2024-03-21 13:30:17.037777'
WHERE id='53';

INSERT INTO feedback_feedback (User_id, motivation, muskulaere_erschoepfung, koerperliche_einschraenkung, schlaf, stress, created_at)
VALUES ('jochen@abc.com', 1, 2, 3, 4, 5, '2024-03-21 13:30:17.037777');