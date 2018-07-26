CREATE TABLE joined AS
select
	g_tbl.id as g_keys,
	a_tbl.id as a_keys
from
	google_tokens g_tbl
inner join
	amazon_tokens a_tbl
on
	g_tbl.blocking_key=a_tbl.blocking_key;

create table frequency as select (g_keys || '~' || a_keys) as keys,count(1) as freq from joined group by keys;
create table actual as select keys from frequency where freq < 3;


