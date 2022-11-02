WITH final AS (
	SELECT
		{{ dbt_utils.surrogate_key (["id"]) }} AS "id",
		"id" AS "number"
	FROM
		{{ source ("public", "groups") }}
)
SELECT
	*
FROM
	final
