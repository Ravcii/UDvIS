WITH final AS (
	SELECT
		{{ dbt_utils.surrogate_key (["id", "short_name"]) }} AS "id",
		"id" AS "old_id",
		"short_name"
	FROM
		{{ source ("public", "routes") }}
)
SELECT
	*
FROM
	final
