Create database Apple_sales;
use  Apple_sales;

CREATE TABLE category (
    category_id VARCHAR(10) PRIMARY KEY,
    category_name VARCHAR(50) NOT NULL
);

CREATE TABLE product (
    product_id VARCHAR(10) PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category_id VARCHAR(10),
    launch_date DATE,
    price DECIMAL(10, 2),
    FOREIGN KEY (category_id) REFERENCES category(category_id)
);


CREATE TABLE store (
    store_id VARCHAR(10) PRIMARY KEY,
    store_name VARCHAR(100) NOT NULL,
    city VARCHAR(50),
    country VARCHAR(50)
);

CREATE TABLE sales (
    sale_id VARCHAR(20) PRIMARY KEY,
    product_id VARCHAR(10),
    store_id VARCHAR(10),
    sale_date DATE,
    quantity INT,
    total_amount DECIMAL(12, 2),
    FOREIGN KEY (product_id) REFERENCES product(product_id),
    FOREIGN KEY (store_id) REFERENCES store(store_id)
);

CREATE TABLE warranty (
    claim_id VARCHAR(20) PRIMARY KEY,
    claim_date DATE,
    sale_id VARCHAR(20),
    repair_status VARCHAR(50),
    FOREIGN KEY (sale_id) REFERENCES sales(sale_id)
);

