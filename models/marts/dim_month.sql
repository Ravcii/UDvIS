WITH dim_days AS (
	SELECT DISTINCT
		"day"
	FROM
		{{ ref ("int_days") }}
),
months AS (
	SELECT DISTINCT
		TO_CHAR("day", 'Month') AS "month"
FROM
	dim_days
),
final AS (
	SELECT DISTINCT
		{{ dbt_utils.surrogate_key (["month"]) }} AS "id",
		"month"
	FROM
		months
)
SELECT
	*
FROM
	final
