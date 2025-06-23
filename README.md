# Task---1 (Library - IIITDM)

readme_file = base_path / "README.md"
readme_file.write_text("""# Library Database Project

## Overview
A relational database schema for a Library Management System that supports multiple copies of books, borrowing limits, fines, and renewals.

## Features
- A member can borrow up to 4 books at a time.
- A book can be renewed up to 3 times.
- Rs. 1 fine is charged per day after due date.
- Each book can have multiple physical copies.
- Full ER diagram and SQL code included.

## Tools Used
- MySQL Workbench

## Files Included
- `LibraryIIITDMK.sql`: Complete SQL schema with procedures, triggers, and views.
- `library_er_diagram.png`: Entity Relationship diagram.
- `sample_data.sql`: Sample data to test the schema.

## How to Use
1. Execute `LibraryIIITDMK.sql` in MySQL.
2. Run `sample_data.sql` to populate tables.
3. Use `CALL RenewBook(loan_id);` to renew books.
4. Use `CALL ReturnBook(loan_id);` to return books and calculate fines.
""")

# Sample data
sample_data = base_path / "sample_data.sql"
sample_data.write_text("""-- Sample Categories
INSERT INTO Categories (name) VALUES ('Fiction'), ('Science'), ('History');

-- Sample Authors
INSERT INTO Authors (name) VALUES ('J.K. Rowling'), ('Isaac Asimov'), ('Yuval Noah Harari');

-- Sample Books
INSERT INTO Books (title, category_id) VALUES ('Harry Potter', 1), ('Foundation', 2), ('Sapiens', 3);

-- BookAuthors links
INSERT INTO BookAuthors (book_id, author_id) VALUES (1, 1), (2, 2), (3, 3);

-- Book Copies
INSERT INTO BookCopies (book_id, status) VALUES (1, 'available'), (1, 'available'), (2, 'available'), (3, 'available');

-- Members
INSERT INTO Members (name, email) VALUES ('Alice', 'alice@example.com'), ('Bob', 'bob@example.com');

-- Sample Loan (issue copy 1 to member 1)
INSERT INTO Loans (copy_id, member_id) VALUES (1, 1);
""")