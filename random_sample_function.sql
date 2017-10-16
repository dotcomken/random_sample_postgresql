CREATE OR REPLACE FUNCTION "YOUR_SCHEMA"."sample_size_calc" (population_size bigint, confidence_level_percentage integer, error_margin_percentage integer)  RETURNS bigint
  VOLATILE
AS $dbvis$

DECLARE 
N bigint;
z NUMERIC;
E NUMERIC;
p NUMERIC;
q NUMERIC;
BEGIN

N := population_size;
E := error_margin_percentage::NUMERIC / 100;
p := 0.5;
q := 0.5;

IF error_margin_percentage NOT BETWEEN 1 AND 99
THEN RAISE EXCEPTION 'ERROR: Error Margin Percentage has to between 1 and 99.';
END IF;

IF confidence_level_percentage = 90 THEN
    z := 1.645;
ELSIF confidence_level_percentage = 95 THEN 
    z := 1.96;
ELSIF confidence_level_percentage = 99 THEN
    z := 2.58;
ELSE
    RAISE EXCEPTION 'ERROR: Confidence Level Percentage has to be 90,95 or 99.';
END IF;
                       
RETURN CEILING(POWER(z,2) * p * q * N / (POWER(E,2) * (N-1) + POWER(z,2) * p * q));

END;
$dbvis$ LANGUAGE plpgsql
