INSERT INTO Categories (category_id, name) VALUES
(1, 'Fiction'),
(2, 'Science'),
(3, 'History');

INSERT INTO Authors (author_id, name) VALUES
(1, 'J.K. Rowling'),
(2, 'Isaac Asimov'),
(3, 'Yuval Noah Harari');

INSERT INTO Books (book_id, title, category_id) VALUES
(1, 'Harry Potter and the Sorcerer''s Stone', 1),
(2, 'Foundation', 2),
(3, 'Sapiens: A Brief History of Humankind', 3);

INSERT INTO BookAuthors (book_id, author_id) VALUES
(1, 1),
(2, 2),
(3, 3);

INSERT INTO BookCopies (copy_id, book_id, status) VALUES
(101, 1, 'available'),
(102, 1, 'available'),
(201, 2, 'available'),
(301, 3, 'available');

INSERT INTO Members (member_id, name, email) VALUES
(1, 'Ananya', 'ananya@gmail.com'),
(2, 'Babu', 'babu@gmail.com');

INSERT INTO Loans (loan_id, copy_id, member_id, issue_date, due_date, return_date, renewals, fine) VALUES
(1, 101, 1, CURDATE(), DATE_ADD(CURDATE(), INTERVAL 30 DAY), NULL, 0, 0),
(2, 201, 2, CURDATE(), DATE_ADD(CURDATE(), INTERVAL 30 DAY), NULL, 1, 0);