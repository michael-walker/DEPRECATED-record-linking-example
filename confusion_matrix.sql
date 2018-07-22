CREATE TABLE expected_cleaned AS
select
	distinct(google || '~' || amazon) as keys
from
	expected;

CREATE TABLE false_negatives AS
    select
    	a_tbl.keys
    from
        actual a_tbl
        LEFT OUTER JOIN
    	expected_cleaned e_tbl
        ON
    	e_tbl.keys=a_tbl.keys
		WHERE e_tbl.keys IS NULL;

CREATE TABLE false_positives AS
    select
    	e_tbl.keys
    from
    	expected_cleaned e_tbl
    	LEFT OUTER JOIN
    	actual a_tbl
    	ON
    	e_tbl.keys=a_tbl.keys
		WHERE a_tbl.keys IS NULL;

CREATE TABLE true_positives AS
    select
    	e_tbl.keys
    from
    	expected_cleaned e_tbl
    	INNER JOIN
    	actual a_tbl
    	ON
    	e_tbl.keys=a_tbl.keys;