-- create the users for each database
-- CREATE USER IF NOT EXISTS 'develop'@'%' IDENTIFIED BY '123456';
-- GRANT ALL PRIVILEGES ON * . * TO 'develop'@'%';

FLUSH PRIVILEGES;

-- create the databases
CREATE DATABASE IF NOT EXISTS prezo_test;

-- add config prezo
SET GLOBAL log_bin_trust_function_creators = 1;
SET GLOBAL sql_mode = 'NO_ENGINE_SUBSTITUTION';
