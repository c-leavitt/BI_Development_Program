SELECT *
FROM supply_chain_data;

# Standardizing all the columns name to lower case and shortening
ALTER TABLE supply_chain_data
CHANGE `Product type` product_type TEXT,
CHANGE `SKU` sku TEXT,
CHANGE `Price` price DOUBLE,
CHANGE `Availability` availability INT,
CHANGE `Number of products sold` num_products_sold INT,
CHANGE `Revenue generated` rev_generated DOUBLE,
CHANGE `Customer demographics` cust_demo TEXT,
CHANGE `Stock levels` stock_level INT,
CHANGE `Lead times` lead_time INT,
CHANGE `Order quantities` order_qty INT,
CHANGE `Shipping times` ship_time INT,
CHANGE `Shipping carriers` carrier TEXT,
CHANGE `Shipping costs` freight_cost DOUBLE,
CHANGE `Supplier name` supplier TEXT,
CHANGE `Location` location TEXT,
CHANGE `Lead time` supplier_lead_time INT,
CHANGE `Production volumes` prod_vol INT,
CHANGE `Manufacturing lead time` mfg_lead_time INT,
CHANGE `Manufacturing costs` mfg_cost DOUBLE,
CHANGE `Inspection results` insp_result TEXT,
CHANGE `Defect rates` defect_rate DOUBLE,
CHANGE `Transportation modes` trans_mode TEXT,
CHANGE `Routes` route TEXT,
CHANGE `Costs` cost DOUBLE;

# Check for unique values in each column
SELECT
COUNT(DISTINCT product_type) AS unique_prodt_types,
COUNT(DISTINCT sku) AS unique_skus,
COUNT(DISTINCT cust_demo) AS unique_customer_demo,
COUNT(DISTINCT supplier) AS unique_suppliers,
COUNT(DISTINCT location) AS unique_location,
COUNT(DISTINCT carrier) AS unique_carriers,
COUNT(DISTINCT trans_mode) AS unique_trans_modes
FROM supply_chain_data;
# Check for repeating combinations of columns
# Supplier and Location
SELECT 
supplier,
location,
COUNT(*) AS records
FROM supply_chain_data
GROUP BY supplier, location
ORDER BY records DESC;
# Produt Type and SKU
SELECT 
product_type,
sku,
COUNT(*) AS records
FROM supply_chain_data
GROUP BY product_type, sku
ORDER BY records DESC;
# Shipping Carriers and Cost
SELECT
carrier,
freight_cost,
COUNT(*) AS uses
FROM supply_chain_data
GROUP BY carrier, freight_cost
ORDER BY uses DESC;
# Check for shared customer descriptions
SELECT 
cust_demo,
COUNT(*) AS num_orders
FROM supply_chain_data
GROUP BY cust_demo
ORDER BY num_orders DESC;
# Check for repeating transportation & route combos
SELECT 
trans_mode,
route,
COUNT(*) AS count
FROM supply_chain_data
GROUP BY trans_mode, route
ORDER BY count DESC;

# Creating Normalized Tables
CREATE TABLE products (
	product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_type VARCHAR(100),
    sku VARCHAR(100),
    price DOUBLE,
    availability INT,
    stock_level INT,
    lead_time INT
);

CREATE TABLE suppliers (
	supplier_id INT AUTO_INCREMENT PRIMARY KEY,
    supplier_name VARCHAR(100),
    location VARCHAR(100),
    lead_time INT
);

CREATE TABLE sales (
	sale_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    cust_demo TEXT,
    num_products_sold INT,
    rev_generated DOUBLE,
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

CREATE TABLE mfg (
	mfg_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    prod_vol INT,
    mfg_lead_time INT,
    mfg_cost DOUBLE,
    insp_result TEXT,
    defect_rate DOUBLE,
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

CREATE TABLE shipping (
	shipping_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    order_qty INT,
    ship_time INT,
    carrier VARCHAR(100),
    freight_cost DOUBLE,
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

CREATE TABLE logistics (
	logistics_id INT AUTO_INCREMENT PRIMARY KEY,
    trans_mode VARCHAR(100),
    route TEXT,
    cost DOUBLE
);



