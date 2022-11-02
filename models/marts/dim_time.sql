WITH work_order_days AS (
	SELECT DISTINCT
		date(created_at) AS "day"
	FROM
		{{ source ("public", "work_orders") }}
),
report_days AS (
	SELECT DISTINCT
		date(started_at) AS "day"
	FROM
		{{ source ("public", "reports") }}
),
final AS (
	SELECT
		*
	FROM
		work_order_days
	UNION
	SELECT
		*
	FROM
		report_days
)
SELECT
	{{ dbt_utils.surrogate_key (["day"]) }} AS "id",
	"day"
FROM
	final
