CREATE TABLE counts AS
select
	metric,metric_value
from
(
select 0 as display_order, 'MODEL ROWS COUNT' as metric, count(1) as metric_value FROM actual
UNION
select 1,'TEST ROWS COUNT', count(1) FROM expected_cleaned
UNION
select 2,'TRUE POSITIVES COUNT', count(1) FROM true_positives
UNION
select 3,'FALSE POSITIVES COUNT', count(1) FROM false_positives
UNION
select 4,'FALSE NEGATIVES COUNT', count(1) FROM false_negatives
) as tbl_a
order by tbl_a.display_order asc ;

create TABLE metrics AS
select
	2 * tbl_b.precision * tbl_b.recall / (tbl_b.precision + tbl_b.recall) as f_score,
	tbl_b.recall,
	tbl_b.precision,
	tbl_b.tp as true_positive_count,
	tbl_b.fp as false_positive_count,
	tbl_b.fn as false_negative_count
	from(
		select
			tbl_a.train,
			tbl_a.test,
			tbl_a.tp,
			tbl_a.fp,
			tbl_a.fn,
            (tp / (tp + fp)) as precision,
			(tp / (tp + fn)) as recall
		from
			(select
				max(case when metric = 'MODEL ROWS COUNT' then metric_value end) train,
				max(case when metric = 'TEST ROWS COUNT' then metric_value end) test,
				cast((max(case when metric = 'TRUE POSITIVES COUNT' then metric_value end)) as float) tp,
				cast((max(case when metric = 'FALSE POSITIVES COUNT' then metric_value end)) as float) fp,
			 	cast((max(case when metric = 'FALSE NEGATIVES COUNT' then metric_value end)) as float) fn
			  from
				counts
			) as tbl_a
) as tbl_b;