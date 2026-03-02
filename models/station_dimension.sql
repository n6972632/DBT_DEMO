WITH BIKE AS (
    select distinct        
        START_STATIO_ID AS STATION_ID,
        START_STATION_NAME AS STATION_NAME,
        START_LAT AS STATION_LAT,
        START_LNG AS STATION_LNG
    from 
    {{ source('demo', 'bike') }}
)

select 
*
from BIKE
