#Problem 1 SQL Statement

SELECT  'The ' || monthlyCohort || ' cohort has ' || 
ROUND(CAST(exercisedInCohort AS decimal(15,3))/CAST(usersInCohort AS decimal(15,3))*100) 
||'% of users completing an exercise in their first month'
FROM
(SELECT SUBSTRING(CAST(created_at AS VARCHAR(11)), 1, 7) monthlyCohort, COUNT(*) as usersInCohort, 
COUNT(CASE 
	WHEN completion_date <= created_at + interval '1 month' then 1 
END) as exercisedInCohort
FROM user_table INNER JOIN exercise ON user_table.user_id=exercise.user_id
GROUP BY monthlyCohort
ORDER BY monthlyCohort)a
ORDER BY monthlyCohort

#Problem 2 SQL Statement

SELECT  STRING_AGG(organization_name, ', ') || ' have the most sever patient population'
FROM
(SELECT organization_name, AVG(average) average_score
FROM providers JOIN 
(SELECT provider_id, AVG(score) average
FROM phq9
GROUP BY provider_id)a ON a.provider_id = providers.provider_id
GROUP BY organization_name
ORDER BY average_score desc
LIMIT 3)c