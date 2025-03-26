*====================================TO CREATE A NEW DATABASE================================================*
CREATE DATABASE E-com;
USE E-com;

*====================================TO CREATE A NEW TABLE(CUSTOMERS)================================================*
CREATE TABLE customers(
    customer_id INT PRIMARY KEY,
    name VARCHAR(50),
    email VARCHAR(50) UNIQUE,
    password VARCHAR(50)
);

*====================================TO CREATE A NEW TABLE(PRODUCTS)================================================*
CREATE TABLE products(
    product_id INT PRIMARY KEY,
    name VARCHAR(100),
    price DECIMAL(10,2),
    description TEXT,
    stockQuantity INT
);

*====================================TO CREATE A NEW TABLE(CART)================================================*
CREATE TABLE cart (
    cart_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id));

*====================================TO CREATE A NEW TABLE(ORDERS)================================================*
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_price DECIMAL(10,2),
    shipping_address TEXT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);
*====================================TO CREATE A NEW TABLE(ORDER_ITEMS)================================================*
CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

*====================================TO INSERT RECORDS INTO THE CUSTOMERS TABLE================================================*
STEP1:
ALTER TABLE customers 
ADD COLUMN first_name VARCHAR(50),
ADD COLUMN last_name VARCHAR(50),
ADD COLUMN address VARCHAR(255);

STEP2:
ALTER TABLE customers 
DROP COLUMN name,
DROP COLUMN password;

STEP3:
INSERT INTO customers (customer_id, first_name, last_name, email, address) VALUES
(1, 'John', 'Doe', 'johndoe@example.com', '123 Main St, City'),
(2, 'Jane', 'Smith', 'janesmith@example.com', '456 Elm St, Town'),
(3, 'Robert', 'Johnson', 'robert@example.com', '789 Oak St, Village'),
(4, 'Sarah', 'Brown', 'sarah@example.com', '101 Pine St, Suburb'),
(5, 'David', 'Lee', 'david@example.com', '234 Cedar St, District'),
(6, 'Laura', 'Hall', 'laura@example.com', '567 Birch St, County'),
(7, 'Michael', 'Davis', 'michael@example.com', '890 Maple St, State'),
(8, 'Emma', 'Wilson', 'emma@example.com', '321 Redwood St, Country'),
(9, 'William', 'Taylor', 'william@example.com', '432 Spruce St, Province'),
(10, 'Olivia', 'Adams', 'olivia@example.com', '765 Fir St, Territory');

*====================================TO INSERT RECORDS INTO THE PRODUCTS TABLE================================================*
INSERT INTO products (product_id, name, description, price, stockQuantity) VALUES
(1, 'Laptop', 'High-performance laptop', 800.00, 10),
(2, 'Smartphone', 'Latest smartphone', 600.00, 15),
(3, 'Tablet', 'Portable tablet', 300.00, 20),
(4, 'Headphones', 'Noise-canceling', 150.00, 30),
(5, 'TV', '4K Smart TV', 900.00, 5),
(6, 'Coffee Maker', 'Automatic coffee maker', 50.00, 25),
(7, 'Refrigerator', 'Energy-efficient', 700.00, 10),
(8, 'Microwave Oven', 'Countertop microwave', 80.00, 15),
(9, 'Blender', 'High-speed blender', 70.00, 20),
(10, 'Vacuum Cleaner', 'Bagless vacuum cleaner', 120.00, 10);

*====================================TO INSERT RECORDS INTO THE ORDERS TABLE================================================*
STEP1:
ALTER TABLE orders 
DROP COLUMN shipping_adress;

STEP2:
INSERT INTO orders (order_id, customer_id, order_date, total_price) VALUES
(1, 1, '2023-01-05', 1200.00),
(2, 2, '2023-02-10', 900.00),
(3, 3, '2023-03-15', 300.00),
(4, 4, '2023-04-20', 150.00),
(5, 5, '2023-05-25', 1800.00),
(6, 6, '2023-06-30', 400.00),
(7, 7, '2023-07-05', 700.00),
(8, 8, '2023-08-10', 160.00),
(9, 9, '2023-09-15', 140.00),
(10, 10, '2023-10-20', 1400.00);

*====================================TO INSERT RECORDS INTO THE ORDER_ITEMS TABLE================================================*
STEP1:
ALTER TABLE order_items 
ADD COLUMN itemAmount DECIMAL(10,2); 

STEP2:
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, itemAmount) VALUES
(1, 1, 1, 2, 1600.00),
(2, 1, 3, 1, 300.00),
(3, 2, 2, 3, 1800.00),
(4, 3, 5, 2, 1800.00),
(5, 4, 4, 4, 600.00),
(6, 4, 6, 1, 50.00),
(7, 5, 1, 1, 800.00),
(8, 5, 2, 2, 1200.00),
(9, 6, 10, 2, 240.00),
(10, 6, 9, 3, 210.00);

*====================================TO INSERT RECORDS INTO THE CART TABLE================================================*
INSERT INTO cart (cart_id, customer_id, product_id, quantity) VALUES
(1, 1, 1, 2),
(2, 1, 3, 1),
(3, 2, 2, 3),
(4, 3, 4, 4),
(5, 3, 5, 2),
(6, 4, 6, 1),
(7, 5, 1, 1),
(8, 6, 10, 2),
(9, 6, 9, 3),
(10, 7, 7, 2);

=========================================1. Update refrigerator product price to 800===========================================================
UPDATE products SET price = 800 WHERE name = 'Refrigerator';

=========================================2. Remove all cart items for a specific customer.=====================================================
DELETE * FROM cart;

=========================================3. Retrieve Products Priced Below $100.===============================================================
SELECT * FROM products WHERE price < 100;

=========================================4. Find Products with Stock Quantity Greater Than 5.==================================================
SELECT * FROM products WHERE stockQuantity > 5;

=========================================5. Retrieve Orders with Total Amount Between $500 and $1000.==========================================
SELECT * FROM orders WHERE total_price BETWEEN 500 AND 1000;

=========================================6. Find Products which name end with letter ‘r’.======================================================
SELECT * FROM products WHERE name LIKE '%r';

=========================================7. Retrieve Cart Items for Customer 5.================================================================
SELECT * FROM cart WHERE customer_id = 5;

=========================================8. Find Customers Who Placed Orders in 2023.==========================================================
SELECT DISTINCT c.* FROM customers c 
JOIN Orders o ON c.customer_id = o.customer_id 
WHERE YEAR(o.order_date) = 2023;

=========================================9. Determine the Minimum Stock Quantity for Each Product Category.====================================
SELECT MIN(stockQuantity) FROM products;

=========================================10. Calculate the Total Amount Spent by Each Customer.================================================
SELECT c.customer_id, c.name, SUM(o.total_price) AS totalSpent 
FROM customers c JOIN orders o ON c.customer_id = o.customer_id 
GROUP BY c.customerID, c.name;

=========================================11. Find the Average Order Amount for Each Customer.==================================================
SELECT customer_id, AVG(total_price) AS avgOrderAmount FROM orders 
GROUP BY customer_id;

=========================================12. Count the Number of Orders Placed by Each Customer.===============================================
SELECT customer_id, COUNT(*) AS orderCount FROM orders 
GROUP BY customer_id;

=========================================13. Find the Maximum Order Amount for Each Customer.==================================================
SELECT customer_id, MAX(total_price) AS maxOrderAmount FROM orders 
GROUP BY customer_id;

=========================================14. Get Customers Who Placed Orders Totaling Over $1000.==============================================
SELECT c.customer_id, c.name FROM customers c 
JOIN orders o ON c.customer_id = o.customer_id 
GROUP BY c.customer_id, c.name 
HAVING SUM(o.total_price) > 1000;

=========================================15. Subquery to Find Products Not in the Cart.========================================================
SELECT * FROM products 
WHERE product_id NOT IN (SELECT DISTINCT product_id FROM cart);

=========================================16. Subquery to Find Customers Who Havent Placed Orders.==============================================
SELECT * FROM customers 
WHERE customer_id NOT IN (SELECT DISTINCT customer_id FROM orders);

=========================================17. Subquery to Calculate the Percentage of Total Revenue for a Product.==============================
SELECT p.product_id, p.name, 
       (SUM(oi.quantity * p.price) * 100 / (SELECT SUM(total_price) FROM orders)) AS revenuePercentage
FROM Products p 
JOIN Order_Items oi ON p.product_id = oi.product_id
GROUP BY p.product_id, p.name;

========================================18. Subquery to Find Products with Low Stock.==========================================================
SELECT * FROM products 
WHERE stockQuantity < (SELECT AVG(stockQuantity) FROM products);

========================================19. Subquery to Find Customers Who Placed High-Value Orders.===========================================
SELECT DISTINCT c.* FROM customers c 
JOIN orders o ON c.customer_id = o.customer_id 
WHERE o.total_price > (SELECT AVG(total_price) FROM orders);
