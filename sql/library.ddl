# ddl statements

drop database library;
create database library;
use library;
CREATE TABLE librarian(
	librarian_id VARCHAR(100) UNIQUE NOT NULL,
    name VARCHAR(100),
    address VARCHAR(100),
    password VARCHAR(100),
    PRIMARY KEY (librarian_id)
);
CREATE TABLE user (
    user_id VARCHAR(100) UNIQUE NOT NULL,
    name VARCHAR(100) NOT NULL,
	role VARCHAR(100),
    password VARCHAR(100),
    unpaid_fines decimal(6,2) DEFAULT 0.00,
    address VARCHAR(100),
    PRIMARY KEY (user_id)
);
CREATE TABLE books(
	isbn VARCHAR(100) UNIQUE not null,
    author VARCHAR(100),
    title VARCHAR(100),
    rating DECIMAL(4,2) DEFAULT 0,
	current_status VARCHAR(100) DEFAULT 'AVAILABLE',
	copy_number INT,
	year_of_publication INT,
    PRIMARY KEY (isbn)
);
CREATE TABLE shelf (
    shelf_id VARCHAR(100) UNIQUE NOT NULL,
    capacity INT,
    PRIMARY KEY (shelf_id)
);

CREATE TABLE genre (
	genre_id VARCHAR(100) NOT NULL,
    name VARCHAR(100) NOT NULL,
    PRIMARY KEY (genre_id)
);

## relations below

CREATE TABLE keeps_track (
	librarian_id VARCHAR(100) NOT NULL,
    user_id VARCHAR(100) NOT NULL,
    PRIMARY KEY (librarian_id, user_id),
    FOREIGN KEY (librarian_id) REFERENCES librarian(librarian_id),
    FOREIGN KEY (user_id) REFERENCES user(user_id)
);

CREATE TABLE maintain (
	librarian_id VARCHAR(100) NOT NULL,
    isbn VARCHAR(100) NOT NULL,
    PRIMARY KEY (librarian_id, isbn),
    FOREIGN KEY (librarian_id) REFERENCES librarian(librarian_id),
    FOREIGN KEY (isbn) REFERENCES books(isbn)
);

CREATE TABLE belongs_to (
	genre_id VARCHAR(100) NOT NULL,
    isbn VARCHAR(100) NOT NULL,
    PRIMARY KEY (genre_id, isbn),
    FOREIGN KEY (genre_id) REFERENCES genre(genre_id),
    FOREIGN KEY (isbn) REFERENCES books(isbn)
);

CREATE TABLE favourite (
	genre_id VARCHAR(100) NOT NULL,
    user_id VARCHAR(100) NOT NULL,
    PRIMARY KEY (genre_id, user_id),
    FOREIGN KEY (genre_id) REFERENCES genre(genre_id),
    FOREIGN KEY (user_id) REFERENCES user(user_id)
);

CREATE TABLE reading_list (
	isbn VARCHAR(100) NOT NULL,
    user_id VARCHAR(100) NOT NULL,
    name VARCHAR(100),
    PRIMARY KEY (isbn, user_id, name),
    FOREIGN KEY (isbn) REFERENCES books(isbn),
    FOREIGN KEY (user_id) REFERENCES user(user_id)
);

CREATE TABLE personal_book_shelf (
	isbn VARCHAR(100) NOT NULL,
    user_id VARCHAR(100) NOT NULL,
    shelf_name VARCHAR(100) NOT NULL,
    PRIMARY KEY (isbn, user_id),
    FOREIGN KEY (isbn) REFERENCES books(isbn),
    FOREIGN KEY (user_id) REFERENCES user(user_id)
);

CREATE TABLE issue (
	isbn VARCHAR(100) NOT NULL,
    user_id VARCHAR(100) NOT NULL,
    due_date DATE,
    issue_email_date DATE,
    PRIMARY KEY (isbn, user_id),
    FOREIGN KEY (isbn) REFERENCES books(isbn),
    FOREIGN KEY (user_id) REFERENCES user(user_id)
);

CREATE TABLE hold (
	isbn VARCHAR(100) NOT NULL,
    user_id VARCHAR(100) NOT NULL,
    hold_date DATE,
    hold_email_date DATE,
    hold_status VARCHAR (200) DEFAULT "AVAILABLE",
    PRIMARY KEY (isbn, user_id),
    FOREIGN KEY (isbn) REFERENCES books(isbn),
    FOREIGN KEY (user_id) REFERENCES user(user_id)
);

CREATE TABLE return_books (
	isbn VARCHAR(100) NOT NULL,
    user_id VARCHAR(100) NOT NULL,
    return_date DATE,
    issue_date DATE,
    fine DECIMAL(6,2),
    PRIMARY KEY (isbn, user_id),
    FOREIGN KEY (isbn) REFERENCES books(isbn),
    FOREIGN KEY (user_id) REFERENCES user(user_id)
);

CREATE TABLE rate (
	isbn VARCHAR(100) NOT NULL,
    user_id VARCHAR(100) NOT NULL,
    rating DECIMAL(4,2) DEFAULT 0,
    review VARCHAR(200),
    PRIMARY KEY (isbn, user_id),
    FOREIGN KEY (isbn) REFERENCES books(isbn),
    FOREIGN KEY (user_id) REFERENCES user(user_id)
);

CREATE TABLE friend (
	user_id VARCHAR(100) NOT NULL,
    friend_id VARCHAR(100) NOT NULL,
    PRIMARY KEY (friend_id, user_id),
    FOREIGN KEY (friend_id) REFERENCES user(user_id),
    FOREIGN KEY (user_id) REFERENCES user(user_id)
);

## 16 tables total 5 entity, 11 relations



