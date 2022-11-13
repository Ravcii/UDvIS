WITH day_with_month AS (
	SELECT
		"day",
		TO_CHAR(d.day, 'Month') AS "month"
	FROM
		{{ ref ("int_days") }} d
),
final AS (
	SELECT
		{{ dbt_utils.surrogate_key (["day", "d.month"]) }} AS "id",
		m.id AS "id_month",
		"day"
	FROM
		day_with_month d
		JOIN {{ ref ("dim_month") }} m ON m.month = d.month
)
SELECT
	*
FROM
	final
