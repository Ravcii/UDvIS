WITH base_vehicle AS (
	SELECT
		"id",
		(floor(random() * (100 - 10 + 1)) + 10) AS "capacity"
	FROM
		{{ ref ("dim_vehicle") }}
),
final AS (
	SELECT
		{{ dbt_utils.surrogate_key (["id", "capacity"]) }} AS "id",
		"capacity",
		"id" AS "id_vehicle"
	FROM
		base_vehicle
)
SELECT
	*
FROM
	final
