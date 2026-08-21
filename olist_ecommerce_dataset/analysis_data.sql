--- 1: Seller Performance & Concentration

SELECT
    s.seller_id,
    s.seller_city,
    s.seller_state,
    count(DISTINCT oi.order_id) AS total_orders,
    round(sum(oi.price),2) AS total_revenue,
    ROUND(
        100.0 * SUM(oi.price) / SUM(SUM(oi.price)) OVER (), 
        2
    ) AS revenue_share_pct
FROM sellers s
JOIN order_items oi ON s.seller_id = oi.seller_id
GROUP BY s.seller_id, s.seller_city, s.seller_state
ORDER BY total_revenue DESC
LIMIT 10;


--- 2: Impact of Shipping Delay on Review

SELECT 
    CASE 
        WHEN o.order_delivered_customer_date > o.order_estimated_delivery_date THEN 'Late'
        ELSE 'On Time'
    END AS status_deliveri,
    
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(AVG(r.review_score), 2) AS avg_review_score,
    ROUND(
        100.0 * COUNT(*) FILTER (WHERE r.review_score <= 2) / COUNT(r.review_id), 
        2
    ) AS presentase_bad_review

FROM orders o
JOIN order_reviews r ON o.order_id = r.order_id
WHERE o.order_status = 'delivered' 
  AND o.order_delivered_customer_date IS NOT NULL
GROUP BY 1;


--- 3: Customer Retention & Repeat Purchase Rate:

WITH customer_order_frequency AS (
    SELECT
        c.customer_unique_id,
        count(o.order_id) AS total_orders
    FROM customers c 
    JOIN orders o ON c.customer_id = o.customer_id
    WHERE o.order_status = 'delivered'
    GROUP BY c.customer_unique_id
),

 customer_segment AS (
    SELECT
        customer_unique_id,
        total_orders,
        CASE
            WHEN total_orders = 1 THEN '1 Order'
            WHEN total_orders = 2 THEN '2 Orders'
            ELSE '3+ Orders'
        END AS frequency_group
    FROM customer_order_frequency
)
SELECT
    frequency_group,
    count(*) AS total_customer,
    round(
        100.0 * count(*) / sum(count(*)) over(),
        2
    ) AS pct_of_total_customer
FROM customer_segment
group BY frequency_group
order BY total_customer DESC;



--- 4: Highest Freight Cost Ratio by Product Category.

SELECT
    COALESCE(pct.product_category_name_english, p.product_category_name, 'Unknown') AS category_english,
    COUNT(oi.order_id) AS total_items,
    ROUND(SUM(oi.price), 2) AS total_price,
    ROUND(SUM(oi.freight_value), 2) AS total_freight,
    round(
        100.0 * SUM(oi.freight_value) / SUM(oi.price) , 2
    ) AS freight_pct_rasio
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
LEFT JOIN product_category_translation pct ON p.product_category_name = pct.product_category_name
GROUP BY category_english
HAVING COUNT(oi.order_id) >= 100
ORDER BY freight_pct_rasio DESC
LIMIT 5;