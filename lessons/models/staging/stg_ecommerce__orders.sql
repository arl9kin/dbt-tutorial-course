{{
	config(
		unique_key='order_id',
		partition_by={
			"field": "created_at",
			"data_type": "timestamp",
			"granularity": "day"
		}
	)
}}
WITH source AS (
        SELECT *

        FROM {{ source('thelook_ecommerce', 'orders') }}
)

SELECT
        order_id,
        user_id,
        status,
        created_at,
        returned_at,
        shipped_at,
        delivered_at,
        num_of_item

FROM source
