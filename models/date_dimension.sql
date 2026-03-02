WITH CTE AS (
    select        
        TO_TIMESTAMP(STARTED_AT) AS STARTED_AT,
        DATE(TO_TIMESTAMP(STARTED_AT)) AS DATE_STARTED_AT,
        HOUR(TO_TIMESTAMP(STARTED_AT)) AS HOUR_STARTED_AT,
        CASE
            WHEN DAYNAME(TO_TIMESTAMP(STARTED_AT)) IN ('Sat', 'Sun')
                THEN 'Weekend'
                ELSE 'Business Day'
            END AS DAY_TYPE,
        CASE
            WHEN MONTH(TO_TIMESTAMP(STARTED_AT)) IN (12,1,2)
                THEN 'Winter'
            WHEN MONTH(TO_TIMESTAMP(STARTED_AT)) IN (3,4,5)
                THEN 'Spring'
            WHEN MONTH(TO_TIMESTAMP(STARTED_AT)) IN (6,7,8)
                THEN 'Summer'
                ELSE 'Autumn'
            END AS STATION_OF_YEAR
    from 
    {{ source('demo', 'bike') }}
    where STARTED_AT != 'STARTED_AT'
)

select 
*
from CTE