WITH final AS (
	SELECT DISTINCT
		date(started_at) AS "day"
	FROM
		{{ source ("public", "reports") }}
)
SELECT
	*
FROM
	final
