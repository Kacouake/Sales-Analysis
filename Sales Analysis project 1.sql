-- Drop the tables (removes data and structure)
DROP TABLE IF EXISTS Sales;

DROP TABLE IF EXISTS Customers;

DROP TABLE IF EXISTS Products;

-- Create Customer table
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    age INT,
    location VARCHAR(100)
);

-- Create Products table
CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10, 2)
);

-- Create Sales table
CREATE TABLE Sales (
    sales_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    quantity INT,
    sales_date DATE,
    total_price DECIMAL(10, 2),
    FOREIGN KEY (customer_id) REFERENCES Customers (customer_id),
    FOREIGN KEY (product_id) REFERENCES Products (product_id)
);

-- Insert Customers
INSERT INTO
    Customers (customer_id, name, age, location)
VALUES
    (1, 'Jordan', 22, 'Texas'),
    (2, 'Taylor', 20, 'Texas'),
    (3, 'Nick', 25, 'Texas'),
    (4, 'Corrina', 20, 'Texas'),
    (5, 'Daniel', 21, 'Arizona'),
    (6, 'Kacou', 25, 'Chicago'),
    (7, 'Bobby', 30, 'North Carolina'),
    (8, 'Chase', 30, 'Rhode Island'),
    (9, 'Victor', 28, 'Kansas'),
    (10, 'Jacob', 19, 'Arizona');

-- Insert Products
INSERT INTO
    Products (product_id, name, category, price)
VALUES
    (1, 'iPhone 13', 'Electronics', 1100.00),
    (2, 'Monitor', 'Electronics', 520.00),
    (3, 'Microwave', 'Appliance', 110.00),
    (4, 'Couch', 'Furniture', 1300.00),
    (5, 'Standing Lamp', 'Furniture', 30.00),
    (6, 'Coffee maker', 'Appliance', 90.00),
    (7, 'Expresso machine', 'Appliance', 499.00),
    (8, 'Xbox', 'Electronics', 370.00), -- Ensure unique product_id
    (9, 'Playstation', 'Electronics', 499.00);

-- Insert Sales
INSERT INTO
    Sales (
        sales_id,
        customer_id,
        product_id,
        quantity,
        sales_date,
        total_price
    )
VALUES
    (1, 1, 8, 2, '2023-09-15', 740.00), -- Sales for Xbox
    (2, 2, 4, 1, '2024-05-23', 1300.00), -- Sales for Couch
    (3, 3, 1, 1, '2023-06-10', 1100.00), -- Sales for iPhone 13
    (4, 4, 2, 1, '2023-07-12', 520.00), -- Sales for Monitor
    (5, 5, 3, 1, '2023-08-01', 110.00), -- Sales for Microwave
    (6, 6, 4, 1, '2023-09-11', 1300.00), -- Sales for Couch
    (7, 7, 5, 2, '2023-10-05', 60.00), -- Sales for Standing Lamp
    (8, 8, 6, 1, '2023-11-15', 90.00), -- Sales for Coffee maker
    (9, 9, 7, 1, '2023-12-03', 499.00), -- Sales for Expresso machine
    (10, 10, 8, 3, '2023-12-25', 1110.00), -- Sales for Xbox
    (11, 1, 9, 1, '2024-01-05', 499.00), -- Sales for Playstation
    (12, 2, 1, 1, '2024-02-13', 1100.00), -- Sales for iPhone 13
    (13, 3, 2, 1, '2024-03-14', 520.00), -- Sales for Monitor
    (14, 4, 3, 2, '2024-04-16', 220.00), -- Sales for Microwave
    (15, 5, 4, 1, '2024-05-12', 1300.00), -- Sales for Couch
    (16, 6, 5, 1, '2024-06-30', 30.00), -- Sales for Standing Lamp
    (17, 7, 6, 1, '2024-07-07', 90.00), -- Sales for Coffee maker
    (18, 8, 8, 2, '2024-08-01', 740.00), -- Sales for Xbox
    (19, 9, 7, 1, '2024-09-12', 499.00), -- Sales for Expresso machine
    (20, 10, 2, 2, '2024-09-25', 1040.00), -- Sales for Monitor
    (21, 1, 3, 1, '2024-10-05', 110.00), -- Sales for Microwave
    (22, 2, 5, 3, '2024-11-11', 90.00), -- Sales for Standing Lamp
    (23, 3, 6, 1, '2024-12-03', 90.00), -- Sales for Coffee maker
    (24, 4, 9, 1, '2024-12-19', 370.00), -- Sales for Playstation
    (25, 5, 1, 1, '2024-12-23', 1100.00);

-- Sales for iPhone 13
-- Total number of customers
SELECT
    COUNT(*) AS total_customers
FROM
    Customers;

-- Top 5 customer sales
SELECT
    c.name,
    SUM(s.total_price) AS total_sales
FROM
    Sales s
    JOIN Customers c ON s.customer_id = c.customer_id
GROUP BY
    c.name
ORDER BY
    total_sales DESC
LIMIT
    5;

-- Most popular product sales
SELECT
    p.name,
    SUM(s.quantity) AS total_sold
FROM
    Sales s
    JOIN Products p ON s.product_id = p.product_id
GROUP BY
    p.name
ORDER BY
    total_sold DESC;

-- Monthly sales total
SELECT
    MONTH(sales_date) AS month,
    SUM(total_price) AS total_sales
FROM
    Sales
GROUP BY
    month;