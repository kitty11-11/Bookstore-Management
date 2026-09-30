-- ===================================
-- MY SQL PROJECT
-- ===================================
CREATE DATABASE BOOK_STORE;
USE BOOK_STORE;
-- Creation of BOOKS table
DROP TABLE IF EXISTS BOOKS;

CREATE TABLE BOOKS (
    BOOK_ID INT AUTO_INCREMENT PRIMARY KEY,
    TITLE VARCHAR(200),
    AUTHOR VARCHAR(200),
    GENRE VARCHAR(100),
    PUBLISHED_YEAR INT,
    PRICE DECIMAL(10 , 2 ),
    STOCK INT
);

-- Creation of CUSTOMERS table
DROP TABLE  IF EXISTS CUSTOMERS;

CREATE TABLE CUSTOMERS (
    CUSTOMER_ID INT AUTO_INCREMENT PRIMARY KEY,
    NAME VARCHAR(200),
    EMAIL VARCHAR(200),
    PHONE VARCHAR(15),
    CITY VARCHAR(200),
    COUNTRY VARCHAR(150)
);


-- Creation of ORDERS table
DROP TABLE IF EXISTS ORDERS;

CREATE TABLE ORDERS (
    ORDER_ID INT AUTO_INCREMENT PRIMARY KEY,
    CUSTOMER_ID INT,
    BOOK_ID INT,
    FOREIGN KEY (CUSTOMER_ID)
        REFERENCES CUSTOMERS (CUSTOMER_ID),
    FOREIGN KEY (BOOK_ID)
        REFERENCES BOOKS (BOOK_ID),
    ORDER_DATE DATE,
    QUANTITY INT,
    TOTAL_AMOUNT DECIMAL(50 , 2 )
);
USE BOOK_STORE;

SELECT 
    *
FROM
    BOOKS;
SELECT 
    *
FROM
    CUSTOMERS;
SELECT 
    *
FROM
    ORDERS;
-- Retrieve all books in the Fiction genre
SELECT 
    *
FROM
    BOOKS
WHERE
    GENRE = 'Fiction';
--  Find books published after the year 1950
SELECT 
    *
FROM
    BOOKS
WHERE
    PUBLISHED_YEAR > 1950;
-- List all customers from the Canada
SELECT 
    *
FROM
    CUSTOMERS
WHERE
    COUNTRY = 'Canada';
-- Show orders placed in November 2023
SELECT 
    *
FROM
    ORDERS
WHERE
    ORDER_DATE BETWEEN '2023-11-01' AND '2023-11-30';
-- Retrieve the total stock of books available
SELECT 
    SUM(STOCK) AS TOTAL_STOCK
FROM
    BOOKS;
-- Find the details of the most expensive book
SELECT 
    *
FROM
    BOOKS AS EXPENSIVE_BOOK
ORDER BY PRICE DESC
LIMIT 1;
 -- Show all customers who ordered more than 1 quantity of a book
SELECT 
    *
FROM
    ORDERS o
        JOIN
    CUSTOMERS c ON o.CUSTOMER_ID = c.CUSTOMER_ID
WHERE
    QUANTITY > 1;
-- Retrieve all orders where the total amount exceeds $20
SELECT 
    *
FROM
    ORDERS
WHERE
    TOTAL_AMOUNT > 20;
-- List all genres available in the Books table
SELECT DISTINCT
    GENRE
FROM
    BOOKS;
-- Find the book with the lowest stock
SELECT 
    *
FROM
    BOOKS
ORDER BY STOCK ASC
LIMIT 1;
--  Calculate the total revenue generated from all orders
SELECT 
    SUM(TOTAL_AMOUNT) AS TOTAL_REVENUE
FROM
    ORDERS;
-- Retrieve the total number of books sold for each genre
SELECT 
    b.GENRE, SUM(o.QUANTITY)
FROM
    ORDERS o
        JOIN
    BOOKS b ON b.BOOK_ID = o.BOOK_ID
GROUP BY b.GENRE;
-- Find the average price of books in the "Fantasy" genre
SELECT 
    AVG(PRICE) AS AVERAGE_PRICE
FROM
    BOOKS
WHERE
    GENRE = 'FANTASY';
-- List customers who have placed at least 2 orders
SELECT 
    c.CUSTOMER_ID, c.NAME
FROM
    CUSTOMERS c
        JOIN
    ORDERS o ON c.CUSTOMER_ID = o.CUSTOMER_ID
GROUP BY c.CUSTOMER_ID , c.NAME
HAVING COUNT(o.ORDER_ID) >= 2;
-- Find the most frequently ordered book
SELECT 
    b.TITLE, SUM(o.QUANTITY) AS Total_Ordered
FROM
    ORDERS o
        JOIN
    BOOKS b ON o.BOOK_ID = b.BOOK_ID
GROUP BY b.BOOK_ID , b.TITLE
ORDER BY Total_Ordered DESC
LIMIT 1;
-- Show the top 3 most expensive books of 'Fantasy' Genre
SELECT 
    BOOK_ID, TITLE AS TOP_3_MOST_EXPENSIVE_BOOK
FROM
    BOOKS
WHERE
    GENRE = 'FANTASY'
ORDER BY PRICE DESC
LIMIT 3;
--  Retrieve the total quantity of books sold by each author
SELECT 
    b.AUTHOR, SUM(o.QUANTITY) AS TOTAL_QUANTITY_OF_BOOKS_SOLD
FROM
    ORDERS o
        JOIN
    BOOKS b ON b.BOOK_ID = o.BOOK_ID
GROUP BY b.AUTHOR;
-- List the cities where customers who spent over $30 are located
SELECT DISTINCT
    c.CITY
FROM
    CUSTOMERS c
        JOIN
    ORDERS o ON c.CUSTOMER_ID = o.CUSTOMER_ID
WHERE
    o.TOTAL_AMOUNT > 30;
-- Find the customer who spent the most on orders
SELECT 
    c.NAME, SUM(o.TOTAL_AMOUNT) AS Total_Spent
FROM
    CUSTOMERS c
        JOIN
    ORDERS o ON c.CUSTOMER_ID = o.CUSTOMER_ID
GROUP BY c.CUSTOMER_ID , c.NAME
ORDER BY Total_Spent DESC
LIMIT 1;
-- Calculate the stock remaining after fulfilling all orders 
SELECT 
    b.BOOK_ID,
    b.TITLE,
    b.STOCK - COALESCE(SUM(o.QUANTITY), 0) AS Remaining_Stock
FROM
    BOOKS b
        LEFT JOIN
    ORDERS o ON b.BOOK_ID = o.BOOK_ID
GROUP BY b.BOOK_ID , b.TITLE , b.STOCK;

