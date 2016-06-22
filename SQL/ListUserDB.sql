CREATE DATABASE DNNAssingment;
CREATE TABLE Accounts
(
user_fname varchar(20) NOT NULL,
user_lname varchar(20) NOT NULL,
username varchar(20) NOT NULL,
user_email varchar(60) NOT NULL,
date_joined datetime NOT NULL,
PRIMARY KEY (user_email)
);

