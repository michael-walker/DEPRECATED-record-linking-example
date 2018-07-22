CREATE TABLE amazon_cleaned AS
select
	id,
	regexp_replace(regexp_replace(upper(title),' ',' ','g'),'\s+',' ','g') as tokens
FROM
	amazon;
CREATE TABLE amazon_tokens AS
select
	id,
    array_to_string((regexp_matches(tokens, '(\w+)', 'g')),'~',' ') as blocking_key
FROM
	amazon_cleaned;
