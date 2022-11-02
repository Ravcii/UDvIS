WITH final AS (
	SELECT
		{{ dbt_utils.surrogate_key (["id", "name", "phone_number"]) }} AS "id",
		"id" AS "old_id",
		"name",
		"phone_number" AS "phone"
	FROM
		{{ source ("public", "clients") }}
)
SELECT
	*
FROM
	final
