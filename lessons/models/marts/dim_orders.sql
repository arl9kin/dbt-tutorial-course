{{
	config(
		materialized='incremental',
		unique_key='order_id',
		on_schema_change='sync_all_columns',
        cluster_by='order_created_at',
		partition_by={
			"field": "order_created_at",
			"data_type": "timestamp",
			"granularity": "day"
		}
	)
}}

WITH

-- Aggregate measures
order_item_measures AS (
	SELECT
		order_id,
		SUM(item_sale_price) AS total_sale_price,
		SUM(product_cost) AS total_product_cost,
		SUM(item_profit) AS total_profit,
		SUM(item_discount) AS total_discount,

		{%- for department_name in dbt_utils.get_column_values(table=ref('int_ecommerce__order_items_products'), column='product_department') %}
			SUM(IF(product_department = '{{department_name}}', item_sale_price, 0)) AS total_sold_{{department_name.lower()}}swear{% if not loop.last %},{% endif -%}
		{% endfor %}


	FROM {{ ref('int_ecommerce__order_items_products') }}
	GROUP BY 1
)

SELECT
	od.order_id,
	od.created_at AS order_created_at,
	{{ is_weekend ('od.created_at')}} AS order_was_created_on_weekend,
	od.shipped_at AS order_shipped_at,
	od.delivered_at AS order_delivered_at,
	od.returned_at AS order_returned_at,
	od.status AS order_status,
	od.num_of_item AS num_items_ordered,
	om.total_sale_price,
	om.total_product_cost,
	om.total_profit,
	om.total_discount,

	{%- for department_name in departments %}
	om.total_sold_{{department_name.lower()}}swear,
	{%- endfor %}

	TIMESTAMP_DIFF(od.created_at, user_data.first_order_created_at, DAY) AS days_since_first_order

FROM {{ ref('stg_ecommerce__orders') }} AS od
LEFT JOIN order_item_measures AS om
	USING (order_id)
LEFT JOIN {{ ref('int_ecommerce__first_order_created') }} as user_data
	USING (user_id)

{% if is_incremental() %}

WHERE od.created_at > (SELECT MAX(od.created_at) FROM {{ this }})

{% endif %}
