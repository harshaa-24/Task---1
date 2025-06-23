CREATE DATABASE LibraryIIITDMK;
USE LibraryIIITDMK;

CREATE TABLE Members (member_id INT PRIMARY KEY, name VARCHAR(100), email VARCHAR(100));
DESCRIBE Members;


CREATE TABLE Categories (category_id INT PRIMARY KEY, name VARCHAR(50) NOT NULL);
DESCRIBE Categories;

CREATE TABLE Books (book_id INT PRIMARY KEY, title VARCHAR(200) NOT NULL, category_id INT, FOREIGN KEY (category_id) REFERENCES Categories(category_id));
DESCRIBE Books;

CREATE TABLE Authors (author_id INT PRIMARY KEY, name VARCHAR(100) NOT NULL);
DESCRIBE Authors;

CREATE TABLE BookCopies (copy_id INT PRIMARY KEY, book_id INT, status VARCHAR(20) DEFAULT 'available', FOREIGN KEY (book_id) REFERENCES Books(book_id));
DESCRIBE BookCopies;

CREATE TABLE BookAuthors (book_id INT, author_id INT, PRIMARY KEY (book_id, author_id), FOREIGN KEY (book_id) REFERENCES Books(book_id), FOREIGN KEY (author_id) REFERENCES Authors(author_id));
DESCRIBE BookAuthors;

CREATE TABLE Loans (loan_id INT PRIMARY KEY, copy_id INT, member_id INT, issue_date DATE, due_date DATE, return_date DATE DEFAULT NULL, renewals INT DEFAULT 0, fine INT DEFAULT 0, FOREIGN KEY (copy_id) REFERENCES BookCopies(copy_id), FOREIGN KEY (member_id) REFERENCES Members(member_id));
DESCRIBE Loans;


DELIMITER //
CREATE TRIGGER set_due_date_before_insert
BEFORE INSERT ON Loans
FOR EACH ROW
BEGIN
    SET NEW.due_date = DATE_ADD(NEW.issue_date, INTERVAL 30 DAY);
END;
//
DELIMITER ;


DELIMITER //
CREATE PROCEDURE RenewBook(IN loanId INT)
BEGIN
    DECLARE current_renewals INT;
    SELECT renewals INTO current_renewals FROM Loans WHERE loan_id = loanId;

    IF current_renewals < 3 THEN
        UPDATE Loans
        SET due_date = DATE_ADD(due_date, INTERVAL 30 DAY),
            renewals = renewals + 1
        WHERE loan_id = loanId;
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Max renewals reached. Return and borrow again.';
    END IF;
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE ReturnBook(IN loanId INT)
BEGIN
    DECLARE current_due DATE;
    DECLARE days_late INT;

    SELECT due_date INTO current_due FROM Loans WHERE loan_id = loanId;
    SET days_late = DATEDIFF(CURDATE(), current_due);

    IF days_late > 0 THEN
        UPDATE Loans
        SET return_date = CURDATE(),
            fine = days_late
        WHERE loan_id = loanId;
    ELSE
        UPDATE Loans
        SET return_date = CURDATE(),
            fine = 0
        WHERE loan_id = loanId;
    END IF;

    
    UPDATE BookCopies
    SET status = 'available'
    WHERE copy_id = (SELECT copy_id FROM Loans WHERE loan_id = loanId);
END;
//
DELIMITER ;

CREATE VIEW ActiveLoans AS
SELECT member_id, COUNT(*) AS active_loans
FROM Loans
WHERE return_date IS NULL
GROUP BY member_id;
