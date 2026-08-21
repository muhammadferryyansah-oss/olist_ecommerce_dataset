-- 1. Customers Table
DROP TABLE IF EXISTS customers CASCADE;
CREATE TABLE customers (
    customer_id VARCHAR(50) PRIMARY KEY,
    customer_unique_id VARCHAR(50),
    customer_zip_code_prefix INT,
    customer_city VARCHAR(100),
    customer_state VARCHAR(5)
);

-- 2. Geolocation Table
DROP TABLE IF EXISTS geolocation CASCADE;
CREATE TABLE geolocation (
    geolocation_zip_code_prefix INT,
    geolocation_lat NUMERIC(10, 8),
    geolocation_lng NUMERIC(11, 8),
    geolocation_city VARCHAR(100),
    geolocation_state VARCHAR(5)
);

-- 3. Orders Table
DROP TABLE IF EXISTS orders CASCADE;
CREATE TABLE orders (
    order_id VARCHAR(50) PRIMARY KEY,
    customer_id VARCHAR(50),
    order_status VARCHAR(30),
    order_purchase_timestamp TIMESTAMP,
    order_approved_at TIMESTAMP,
    order_delivered_carrier_date TIMESTAMP,
    order_delivered_customer_date TIMESTAMP,
    order_estimated_delivery_date TIMESTAMP
);

-- 4. Category Translation Table
DROP TABLE IF EXISTS product_category_translation CASCADE;
CREATE TABLE product_category_translation (
    product_category_name VARCHAR(100) PRIMARY KEY,
    product_category_name_english VARCHAR(100)
);

-- 5. Products Table
DROP TABLE IF EXISTS products CASCADE;
CREATE TABLE products (
    product_id VARCHAR(50) PRIMARY KEY,
    product_category_name VARCHAR(100),
    product_name_length INT,
    product_description_length INT,
    product_photos_qty INT,
    product_weight_g INT,
    product_length_cm INT,
    product_height_cm INT,
    product_width_cm INT
);

-- 6. Sellers Table
DROP TABLE IF EXISTS sellers CASCADE;
CREATE TABLE sellers (
    seller_id VARCHAR(50) PRIMARY KEY,
    seller_zip_code_prefix INT,
    seller_city VARCHAR(100),
    seller_state VARCHAR(5)
);

-- 7. Order Items Table
DROP TABLE IF EXISTS order_items CASCADE;
CREATE TABLE order_items (
    order_id VARCHAR(50),
    order_item_id INT,
    product_id VARCHAR(50),
    seller_id VARCHAR(50),
    shipping_limit_date TIMESTAMP,
    price NUMERIC(10, 2),
    freight_value NUMERIC(10, 2),
    PRIMARY KEY (order_id, order_item_id)
);

-- 8. Order Payments Table
DROP TABLE IF EXISTS order_payments CASCADE;
CREATE TABLE order_payments (
    order_id VARCHAR(50),
    payment_sequential INT,
    payment_type VARCHAR(30),
    payment_installments INT,
    payment_value NUMERIC(10, 2)
);

-- 9. Order Reviews Table
DROP TABLE IF EXISTS order_reviews CASCADE;
CREATE TABLE order_reviews (
    review_id VARCHAR(50),
    order_id VARCHAR(50),
    review_score INT,
    review_comment_title TEXT,
    review_comment_message TEXT,
    review_creation_date TIMESTAMP,
    review_answer_timestamp TIMESTAMP
);



COPY customers FROM 'C:/path/ke/folder/olist_customers_dataset.csv' WITH (FORMAT csv, HEADER true);
COPY geolocation FROM 'C:/path/ke/folder/olist_geolocation_dataset.csv' WITH (FORMAT csv, HEADER true);
COPY orders FROM 'C:/path/ke/folder/olist_orders_dataset.csv' WITH (FORMAT csv, HEADER true);
COPY product_category_translation FROM 'C:/path/ke/folder/product_category_name_translation.csv' WITH (FORMAT csv, HEADER true);
COPY products FROM 'C:/path/ke/folder/olist_products_dataset.csv' WITH (FORMAT csv, HEADER true);
COPY sellers FROM 'C:/path/ke/folder/olist_sellers_dataset.csv' WITH (FORMAT csv, HEADER true);
COPY order_items FROM 'C:/path/ke/folder/olist_order_items_dataset.csv' WITH (FORMAT csv, HEADER true);
COPY order_payments FROM 'C:/path/ke/folder/olist_order_payments_dataset.csv' WITH (FORMAT csv, HEADER true);
COPY order_reviews FROM 'C:/path/ke/folder/olist_order_reviews_dataset.csv' WITH (FORMAT csv, HEADER true);


SELECT 'customers' AS table_name, COUNT(*) AS row_count FROM customers
UNION ALL
SELECT 'orders', COUNT(*) FROM orders
UNION ALL
SELECT 'order_items', COUNT(*) FROM order_items
UNION ALL
SELECT 'order_payments', COUNT(*) FROM order_payments
UNION ALL
SELECT 'order_reviews', COUNT(*) FROM order_reviews
UNION ALL
SELECT 'products', COUNT(*) FROM products
UNION ALL
SELECT 'sellers', COUNT(*) FROM sellers
UNION ALL
SELECT 'geolocation', COUNT(*) FROM geolocation
UNION ALL
SELECT 'product_category_translation', COUNT(*) FROM product_category_translation;