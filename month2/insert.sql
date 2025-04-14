INSERT IGNORE INTO logistics (trans_mode, route, cost)
SELECT DISTINCT	
	trans_mode,
    route,
    cost
FROM supply_chain_data;

INSERT IGNORE INTO suppliers (supplier, location, lead_time)
SELECT DISTINCT 
	supplier,
	location,
	lead_time
FROM supply_chain_data; 

INSERT IGNORE INTO products (product_type, sku, price, availability, stock_level, lead_time, supplier_id)
SELECT DISTINCT 
	scd.product_type,
	scd.sku,
    scd.price,
	scd.availability, 
	scd.stock_level, 
	scd.lead_time,
    s.supplier_id
FROM supply_chain_data scd
JOIN suppliers s ON scd.supplier = s.supplier
	AND scd.location = s.location
    AND scd.lead_time = s.lead_time;

INSERT IGNORE INTO sales (product_id, cust_demo, num_products_sold, rev_generated)
SELECT DISTINCT
	p.product_id,
    scd.cust_demo,
	scd.num_products_sold,
	scd.rev_generated
FROM supply_chain_data scd
JOIN products p ON scd.sku = p.sku;

INSERT IGNORE INTO mfg (product_id, prod_vol, mfg_lead_time, mfg_cost, insp_result, defect_rate)
SELECT DISTINCT
	p.product_id,
    scd.prod_vol,
    scd.mfg_lead_time,
    scd.mfg_cost,
    scd.insp_result,
    scd.defect_rate
FROM supply_chain_data scd
JOIN products p ON scd.sku = p.sku;

INSERT IGNORE INTO shipping (product_id, order_qty, ship_time, carrier, freight_cost, logistics_id)
SELECT DISTINCT
	p.product_id,
    scd.order_qty,
    scd.ship_time,
    scd.carrier,
    scd.freight_cost,
    l.logistics_id
FROM supply_chain_data scd
JOIN products p ON scd.sku = p.sku
JOIN logistics l ON scd.trans_mode = l.trans_mode
AND scd.route = l.route
AND scd.cost = l.cost;



