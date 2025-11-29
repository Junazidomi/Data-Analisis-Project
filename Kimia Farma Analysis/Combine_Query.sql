-- Create Table Based condition
CREATE TABLE tabel_analisa AS

-- Take the necessary data or columns
SELECT 
  tf.transaction_id,
  tf.date,
  kc.branch_id,
  kc.branch_name,
  kc.kota,
  kc.provinsi,
  kc.rating,
  tf.customer_name,
  p.product_id,
  p.product_name,
  tf.price AS actual_price,
  tf.discount_percentage,
  --- Make a new column based on price named "persentase_gross_laba"
  CASE 
    WHEN tf.price <= 50000 THEN 0.1
    WHEN tf.price > 50000 AND tf.price <= 100000 THEN 0.15
    WHEN tf.price > 100000 AND tf.price <= 300000 THEN 0.2
    WHEN tf.price > 300000 AND tf.price <= 500000 THEN 0.25
    WHEN tf.price > 500000 THEN 0.3
  END AS persentase_gross_laba,
  -- Make a new column based on result of price and discount_percentage named net_sales
  tf.price - (tf.price * tf.discount_percentage) AS net_sales,
  -- Make a new column based on price, dicount_percentage named "net_profit"
  (tf.price- (tf.price * tf.discount_percentage)) *
  CASE 
    WHEN tf.price <=50000 THEN 0.1
    WHEN tf.price > 50000 AND tf.price <= 100000 THEN 0.15
    WHEN tf.price > 100000 AND tf.price <= 300000 THEN 0.2
    WHEN tf.price > 300000 AND tf.price <= 500000 THEN 0.25
    WHEN tf.price > 500000 THEN 0.3 
  END AS net_profit,
  tf.rating AS rating_transaksi
-- Combine 4 tables to final table based on primary key each tabls
FROM kimia_farma.kf_final_transaction AS tf
JOIN kimia_farma.kf_product AS p
ON tf.product_id=p.product_id
JOIN kimia_farma.kf_kantor_cabang as kc
ON tf.branch_id=kc.branch_id
JOIN kimia_farma.kf_inventory AS i
ON tf.product_id=i.product_id
   












