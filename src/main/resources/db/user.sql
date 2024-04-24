CREATE DATABASE snoflo;
-- CREATE USER 'snoflo'@'localhost' IDENTIFIED BY 'Snoflo123!!';
CREATE USER 'snoflo'@'localhost' IDENTIFIED WITH mysql_native_password BY 'Snoflo123!!';
GRANT ALL PRIVILEGES ON snoflo.* TO snoflo@localhost;
FLUSH PRIVILEGES;


