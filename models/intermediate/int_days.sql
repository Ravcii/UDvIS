WITH final AS (
	SELECT
		"day"
	FROM
		{{ ref ("stg_reports__days") }}
	UNION
	SELECT
		"day"
	FROM
		{{ ref ("stg_work_orders__days") }}
)
SELECT
	*
FROM
	final
