WITH base_vehicle AS (
	SELECT
		"id",
		(floor(random() * (10000 - 1000 + 1)) + 1000) AS "weight_cap"
	FROM
		{{ ref ("dim_vehicle") }}
),
final AS (
	SELECT
		{{ dbt_utils.surrogate_key (["id", "weight_cap"]) }} AS "id",
		"weight_cap",
		"id" AS "id_vehicle"
	FROM
		base_vehicle
)
SELECT
	*
FROM
	final
