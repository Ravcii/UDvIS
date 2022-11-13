WITH final AS (
	SELECT DISTINCT
		date(created_at) AS "day"
	FROM
		{{ source ("public", "work_orders") }}
)
SELECT
	*
FROM
	final
