{{ config(severity = 'warn') }}

WITH order_details AS (
    SELECT
        order_id,
        COUNT(*) AS num_of_items_in_order
    FROM {{ ref('stg_ecommerce__order_items')}}
    Group by 1
)

SELECT
    o.*,
    od.*

FROM {{ ref('stg_ecommerce__orders') }} AS o
FULL OUTER JOIN order_details AS od USING(order_id)
WHERE --condition should return something when test fails
    o.order_id IS NULL
    OR od.order_id IS NULL
    OR o.num_of_item != od.num_of_items_in_order
