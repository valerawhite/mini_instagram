SELECT SUM(sum), SUM(c_likes), tinfo.type, info, DATE_FORMAT(time_created, '%H') as hours 
FROM `transaction` as t LEFT JOIN transaction_info as tinfo On t.info = tinfo.id WHERE
t.type = 2 && time_created > DATE_SUB(NOW(), INTERVAL 31 DAY) GROUP BY info


SELECT personaname, SUM(sum) as sum, SUM(c_likes) as likes, t_type.type, U.wallet_balance,
U.wallet_total_likes FROM transaction as T INNER JOIN user as U On T.user_id = U.id 
INNER JOIN transaction_type as t_type On T.type = t_type.id GROUP BY user_id, T.type 