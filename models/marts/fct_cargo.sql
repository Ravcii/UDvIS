WITH final AS (
	SELECT
		dt.id AS "id_day",
		dcv.id AS "id_vehicle",
		dg.id AS "id_group",
		dc.id AS "id_client",
		count(wo.id) AS "total_orders",
		SUM(wo.price) AS "total_money",
		AVG(wo.price) AS "avg_money",
		AVG(wo.weight) AS "avg_weight"
	FROM
		{{ source ("public", "work_orders") }} wo
		JOIN {{ source ("public", "orders") }} orders ON wo.id_order = orders.id
		JOIN {{ ref ("dim_client") }} dc ON dc.old_id = orders.id_client
		JOIN {{ ref ("dim_group") }} dg ON wo.id_brigade = dg.number
		JOIN {{ ref ("dim_vehicle") }} bv ON wo.id_vehicle = bv.old_id
		JOIN {{ ref ("dim_vehicle_cargo") }} dcv ON bv.id = dcv.id_vehicle
		JOIN {{ ref ("dim_time") }} dt ON dt.day = date(created_at)
	GROUP BY
		dt.id,
		dcv.id,
		dg.id,
		dc.id
)
SELECT
	*
FROM
	final
