select * from [show tables from dbms_internal];
select * from [show columns from dbms_internal.active_range_feeds];
select * from [show columns from dbms_internal.backward_dependencies];
select * from [show columns from dbms_internal.builtin_functions];
select * from [show columns from dbms_internal.cluster_contended_indexes];
select * from [show columns from dbms_internal.cluster_contended_keys];
select * from [show columns from dbms_internal.cluster_contended_tables];
select * from [show columns from dbms_internal.cluster_contention_events];
select * from [show columns from dbms_internal.cluster_database_privileges];
select * from [show columns from dbms_internal.cluster_distsql_flows];
select * from [show columns from dbms_internal.cluster_inflight_traces];
select * from [show columns from dbms_internal.cluster_queries];
select * from [show columns from dbms_internal.cluster_sessions];
select * from [show columns from dbms_internal.cluster_settings];
select * from [show columns from dbms_internal.cluster_transactions];
select * from [show columns from dbms_internal.create_statements];
select * from [show columns from dbms_internal.create_type_statements];
select * from [show columns from dbms_internal.cross_db_references];
select * from [show columns from dbms_internal.databases];
select * from [show columns from dbms_internal.default_privileges];
select * from [show columns from dbms_internal.feature_usage];
select * from [show columns from dbms_internal.forward_dependencies];
select * from [show columns from dbms_internal.gossip_alerts];
select * from [show columns from dbms_internal.gossip_liveness];
select * from [show columns from dbms_internal.gossip_network];
select * from [show columns from dbms_internal.gossip_nodes];
select * from [show columns from dbms_internal.index_columns];
select * from [show columns from dbms_internal.index_usage_statistics];
select * from [show columns from dbms_internal.interleaved];
select * from [show columns from dbms_internal.invalid_objects];
select * from [show columns from dbms_internal.jobs];
select * from [show columns from dbms_internal.kv_node_liveness];
select * from [show columns from dbms_internal.kv_node_status];
select * from [show columns from dbms_internal.kv_store_status];
select * from [show columns from dbms_internal.leases];
select * from [show columns from dbms_internal.lost_descriptors_with_data];
select * from [show columns from dbms_internal.node_build_info];
select * from [show columns from dbms_internal.node_contention_events];
select * from [show columns from dbms_internal.node_distsql_flows];
select * from [show columns from dbms_internal.node_inflight_trace_spans];
select * from [show columns from dbms_internal.node_metrics];
select * from [show columns from dbms_internal.node_queries];
select * from [show columns from dbms_internal.node_runtime_info];
select * from [show columns from dbms_internal.node_sessions];
select * from [show columns from dbms_internal.node_statement_statistics];
select * from [show columns from dbms_internal.node_transaction_statistics];
select * from [show columns from dbms_internal.node_transactions];
select * from [show columns from dbms_internal.node_txn_stats];
select * from [show columns from dbms_internal.partitions];
select * from [show columns from dbms_internal.predefined_comments];
select * from [show columns from dbms_internal.ranges];
select * from [show columns from dbms_internal.ranges_no_leases];
select * from [show columns from dbms_internal.regions];
select * from [show columns from dbms_internal.schema_changes];
select * from [show columns from dbms_internal.session_trace];
select * from [show columns from dbms_internal.session_variables];
select * from [show columns from dbms_internal.statement_statistics];
select * from [show columns from dbms_internal.table_columns];
select * from [show columns from dbms_internal.table_indexes];
select * from [show columns from dbms_internal.table_row_statistics];
select * from [show columns from dbms_internal.tables];
select * from [show columns from dbms_internal.tenant_usage_details];
select * from [show columns from dbms_internal.transaction_statistics];
select * from [show columns from dbms_internal.zones];

select * from [show tables from system];
select * from [show columns from system.descriptor];
select * from [show columns from system.span_configurations];
select * from [show columns from system.sql_instances];
select * from [show columns from system.tenant_usage];
select * from [show columns from system.database_role_settings];
select * from [show columns from system.transaction_statistics];
select * from [show columns from system.statement_statistics];
select * from [show columns from system.join_tokens];
select * from [show columns from system.migrations];
select * from [show columns from system.sqlliveness];
select * from [show columns from system.scheduled_jobs];
select * from [show columns from system.statement_diagnostics];
select * from [show columns from system.statement_diagnostics_requests];
select * from [show columns from system.statement_bundle_chunks];
select * from [show columns from system.role_options];
select * from [show columns from system.protected_ts_records];
select * from [show columns from system.protected_ts_meta];
select * from [show columns from system.namespace];
select * from [show columns from system.reports_meta];
select * from [show columns from system.replication_stats];
select * from [show columns from system.replication_critical_localities];
select * from [show columns from system.replication_constraint_stats];
select * from [show columns from system.comments];
select * from [show columns from system.role_members];
select * from [show columns from system.locations];
select * from [show columns from system.table_statistics];
select * from [show columns from system.web_sessions];
select * from [show columns from system.jobs];
select * from [show columns from system.ui];
select * from [show columns from system.rangelog];
select * from [show columns from system.eventlog];
select * from [show columns from system.lease];
select * from [show columns from system.tenants];
select * from [show columns from system.settings];
select * from [show columns from system.zones];
select * from [show columns from system.users];