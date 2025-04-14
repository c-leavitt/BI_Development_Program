INSERT INTO products (product_type, sku, price, availability, stock_level, lead_time)
SELECT DISTINCT 
	product_type,
	sku,
    price,
	availability, 
	stock_level, 
	lead_time
FROM supply_chain_data;

INSERT INTO suppliers (supplier, location, lead_time)
SELECT DISTINCT 
	supplier,
	location,
	lead_time
FROM supply_chain_data; 

INSERT INTO sales (product_id, cust_demo, num_products_sold, rev_generated)
SELECT
	p.product_id,
    scd.cust_demo,
	scd.num_products_sold,
	scd.rev_generated
FROM supply_chain_data scd
JOIN products p ON scd.sku = p.sku;

INSERT INTO mfg (product_id, prod_vol, mfg_lead_time, mfg_cost, insp_result, defect_rate)
SELECT
	p.product_id,
    scd.prod_vol,
    scd.mfg_lead_time,
    scd.mfg_cost,
    scd.insp_result,
    scd.defect_rate
FROM supply_chain_data scd
JOIN products p ON scd.sku = p.sku;

INSERT INTO shipping (product_id, order_qty, ship_time, carrier, freight_cost)
SELECT
	p.product_id,
    scd.order_qty,
    scd.ship_time,
    scd.carrier,
    scd.freight_cost
FROM supply_chain_data scd
JOIN products p ON scd.sku = p.sku;

INSERT INTO logistics (trans_mode, route, cost)
SELECT DISTINCT	
	trans_mode,
    route,
    cost
FROM supply_chain_data;

