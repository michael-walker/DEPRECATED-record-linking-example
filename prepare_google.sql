CREATE TABLE google_cleaned AS
select
    id,
    regexp_replace(regexp_replace(upper(title),' ',' ','g'),'\s+',' ','g') as tokens
FROM
    google;
CREATE TABLE google_tokens AS
select
	id,
    array_to_string((regexp_matches(tokens, '(\w+)\s(\w+)', 'g')),'~',' ') as blocking_key
FROM
	google_cleaned;