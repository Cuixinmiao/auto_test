-- issues/69089
-- txn.restarts.commitdeadlineexceeded
-- kv.transaction.max_intent_bytes
-- txn.restarts.unknown
-- This commit adds a new metric called txn.restarts.commitdeadlineexceeded
-- that tracks the number of transactions that were forced to restart
-- because their commit deadline was exceeded (COMMIT_DEADLINE_EXCEEDED).
-- Prior to this commit, these restarts were categorized under the vague
-- txn.restarts.unknown metric.

select *
from dbms_internal.node_metrics
where name in ('txn.restarts.serializable',
               'txn.restarts.writetooold',
               'txn.restarts.unknown',
               'txn.restarts.commitdeadlineexceeded',
	       'txnwaitqueue.deadlocks_total')
order by name asc;


drop table if exists accounts;
create table accounts(id int primary key , balance decimal(15,2));
-- insert 40kw
insert into accounts select generate_series(1,400000000),generate_series(1,400000000)::dec;
select count(*) from accounts;
update accounts set balance=10 where balance>0;
select count(*) from accounts;
delete from accounts where balance>0;
select count(*) from accounts;
select *
from dbms_internal.node_metrics
where name in ('txn.restarts.serializable',
               'txn.restarts.writetooold',
               'txn.restarts.unknown',
	       'txn.restarts.commitdeadlineexceeded',
               'txnwaitqueue.deadlocks_total')
order by name asc;
drop table accounts;
