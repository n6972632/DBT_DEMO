WITH daily_weather AS (
    select        
        DATE(TIME) as daily_weather,
        WEATHER,
        TEMP,
        PRESSURE,
        HUMIDITY,
        CLOUDS
    from 
    {{ source('demo', 'weather') }}
),

daily_weather_agg as (
    select
        daily_weather,
        WEATHER,
        round(avg(TEMP),2) as AVG_TEMP,
        round(avg(PRESSURE),2) AS AVG_PRESSURE,
        round(avg(HUMIDITY),2) AS AVG_HUMIDITY,
        round(avg(CLOUDS),2) AS AVG_CLOUDS
    from
        daily_weather
    group by daily_weather, weather
    qualify(ROW_NUMBER() OVER (PARTITION BY daily_weather ORDER BY count(weather) desc)) = 1
)

select 
*
from daily_weather_agg

