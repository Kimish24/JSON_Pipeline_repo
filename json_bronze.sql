LIST @JSON_PROJECT.JSON_PROJECT.STG_JSON_RAW;

create schema JSON_Project.BRONZE;

CREATE OR REPLACE TABLE
JSON_Project.BRONZE.BRONZE_JSON
(
    PAYLOAD         VARIANT,
    FILE_NAME       VARCHAR,
    FILE_ROW_NUMBER NUMBER,
    LOAD_TIMESTAMP  TIMESTAMP_LTZ
);
----------------------------------------

USE DATABASE JSON_PROJECT;
USE SCHEMA JSON_PROJECT;

CREATE OR REPLACE FILE FORMAT FF_JSON
    TYPE = 'JSON';

SHOW FILE FORMATS IN SCHEMA JSON_PROJECT.JSON_PROJECT;

TRUNCATE TABLE JSON_PROJECT.BRONZE.BRONZE_JSON;

COPY INTO JSON_PROJECT.BRONZE.BRONZE_JSON
(
    PAYLOAD,
    FILE_NAME,
    FILE_ROW_NUMBER,
    LOAD_TIMESTAMP
)

FROM
(
    SELECT
        t.$1,
        METADATA$FILENAME,
        METADATA$FILE_ROW_NUMBER,
        METADATA$START_SCAN_TIME

    FROM @JSON_PROJECT.JSON_PROJECT.STG_JSON_RAW
    (
        FILE_FORMAT => JSON_PROJECT.JSON_PROJECT.FF_JSON
    ) t
)

ON_ERROR = 'ABORT_STATEMENT';

select * from JSON_Project.BRONZE.BRONZE_JSON;




SELECT
    f.KEY,
    f.VALUE
FROM JSON_PROJECT.BRONZE.BRONZE_JSON b,
LATERAL FLATTEN(
    INPUT => b.PAYLOAD
) f;





SELECT

    f.KEY AS RECORD_ID,

    f.VALUE:"Contient"::STRING AS CONTINENT,

    f.VALUE:"Country_State"::STRING AS COUNTRY_STATE,

    f.VALUE:"URL"::STRING AS URL,

    f.VALUE:"cook_time"::STRING AS COOK_TIME,

    f.VALUE:"cuisine"::STRING AS CUISINE,

    f.VALUE:"description"::STRING AS DESCRIPTION,

    f.VALUE:"ingredients"::VARIANT AS INGREDIENTS,

    f.VALUE:"instructions"::VARIANT AS INSTRUCTIONS,

    f.VALUE:"nutrients"::VARIANT AS NUTRIENTS,

    f.VALUE:"prep_time"::STRING AS PREP_TIME,

    f.VALUE:"rating"::STRING AS RATING,

    f.VALUE:"serves"::VARCHAR AS SERVES,

    f.VALUE:"title"::STRING AS TITLE,

    f.VALUE:"total_time"::STRING AS TOTAL_TIME

FROM JSON_PROJECT.BRONZE.BRONZE_JSON b,

LATERAL FLATTEN(
    INPUT => b.PAYLOAD
) f;



select * from JSON_PROJECT.BRONZE.BRONZE_JSON;

 create or replace table json_project.silver.SILVER_JSON as


SELECT

    f.KEY AS RECORD_ID,

    f.VALUE:"Contient"::STRING AS CONTINENT,

    f.VALUE:"Country_State"::STRING AS COUNTRY_STATE,

    f.VALUE:"URL"::STRING AS URL,

    f.VALUE:"cook_time"::STRING AS COOK_TIME,

    f.VALUE:"cuisine"::STRING AS CUISINE,

    f.VALUE:"description"::STRING AS DESCRIPTION,

    f.VALUE:"ingredients"::VARIANT AS INGREDIENTS,

    f.VALUE:"ingredients"[0]::VARIANT AS INGREDIENTS_0,

    f.VALUE:"ingredients"[1]::VARIANT AS INGREDIENTS_1,

    f.VALUE:"ingredients"[2]::VARIANT AS INGREDIENTS_2,

    f.VALUE:"ingredients"[3]::VARIANT AS INGREDIENTS_3,

    f.VALUE:"ingredients"[4]::VARIANT AS INGREDIENTS_4,

    f.VALUE:"ingredients"[5]::VARIANT AS INGREDIENTS_5,

    f.VALUE:"instructions"::VARIANT AS INSTRUCTIONS,JSON_PROJECT

    f.VALUE:"instructions"[0]::VARIANT AS INSTRUCTIONS_0,

    f.VALUE:"instructions"[1]::VARIANT AS INSTRUCTIONS_1,

    f.VALUE:"nutrients"::VARIANT AS NUTRIENTS,

    f.VALUE:"nutrients":"calories"::STRING AS calories,

    f.VALUE:"nutrients":"carbohydrateContent"::STRING AS carbohydrateContent,

    f.VALUE:"nutrients":"cholesterolContent"::STRING AS cholesterolContent,
    
    f.VALUE:"nutrients":"fatContent"::STRING AS fatContent,
    
    f.VALUE:"nutrients":"fiberContent"::STRING AS fiberContent,
    
    f.VALUE:"nutrients":"proteinContent"::STRING AS proteinContent,
    
    f.VALUE:"nutrients":"saturatedFatContent"::STRING AS saturatedFatContent,
    
    f.VALUE:"nutrients":"sodiumContent"::STRING AS sodiumContent,
    
    f.VALUE:"nutrients":"sugarContent"::STRING AS sugarContent,
    
    f.VALUE:"nutrients":"unsaturatedFatContent"::STRING AS unsaturatedFatContent,
    
    f.VALUE:"prep_time"::STRING AS PREP_TIME,

    f.VALUE:"rating"::STRING AS RATING,

    f.VALUE:"serves"::VARCHAR AS SERVES,

    f.VALUE:"title"::STRING AS TITLE,

    f.VALUE:"total_time"::STRING AS TOTAL_TIME

FROM JSON_PROJECT.BRONZE.BRONZE_JSON b,

LATERAL FLATTEN(
    INPUT => b.PAYLOAD
) f;


select * from json_project.silver.SILVER_JSON;

