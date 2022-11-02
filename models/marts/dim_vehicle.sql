WITH final AS (
	SELECT
		{{ dbt_utils.surrogate_key (["id", "brand", "model", "plate"]) }} AS "id",
		"id" AS "old_id",
		"brand",
		"model",
		"plate"
	FROM
		{{ source ("public", "vehicles") }}
)
SELECT
	*
FROM
	final
