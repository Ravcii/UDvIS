WITH final AS (
	SELECT
		{{ dbt_utils.surrogate_key (["dt.id", "dpv.id", "dg.id", "dr.id"]) }} AS "id",
		dt.id AS "id_day",
		dpv.id AS "id_vehicle",
		dg.id AS "id_group",
		dr.id AS "id_route",
		count(re.id) AS "total_runs",
		SUM(re.passengers_count) AS "total_passengers",
		SUM(re.passengers_count * ro.price) AS "total_money",
		AVG(re.passengers_count) AS "avg_passengers",
		AVG(re.passengers_count * ro.price) AS "avg_money"
	FROM
		{{ source ("public", "schedules") }} s
		FULL JOIN {{ source ("public", "reports") }} re ON s.id = re.id_schedule
		JOIN {{ source ("public", "routes") }} ro ON s.id_route = ro.id
		JOIN {{ ref ("dim_route") }} dr ON dr.old_id = ro.id
		JOIN {{ ref ("dim_group") }} dg ON s.id_brigade = dg.number
		JOIN {{ ref ("dim_vehicle") }} bv ON s.id_vehicle = bv.old_id
		JOIN {{ ref ("dim_vehicle_public") }} dpv ON bv.id = dpv.id_vehicle
		JOIN {{ ref ("dim_day") }} dt ON dt.day = date(started_at)
	GROUP BY
		dt.id,
		dpv.id,
		dg.id,
		dr.id
)
SELECT
	*
FROM
	final
