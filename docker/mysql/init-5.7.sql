-- create the databases
CREATE DATABASE IF NOT EXISTS prezo_test;
CREATE DATABASE IF NOT EXISTS prezo;

-- add config prezo
SET GLOBAL log_bin_trust_function_creators = 1;
SET GLOBAL sql_mode = 'NO_ENGINE_SUBSTITUTION';

-- create the users for each database
-- CREATE USER IF NOT EXISTS 'develop'@'%' IDENTIFIED BY '123456';
GRANT ALL PRIVILEGES ON * . * TO 'develop'@'%';

FLUSH PRIVILEGES;
