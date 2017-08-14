-- ----------------------------------------------------------------------
-- Test: manage resource group in transaction
-- ----------------------------------------------------------------------

--start_ignore
DROP RESOURCE GROUP rg_test_group;
--end_ignore

-- helper view to check the resgroup status
CREATE OR REPLACE VIEW rg_test_monitor AS
	SELECT groupname, concurrency, proposed_concurrency, cpu_rate_limit
	FROM gp_toolkit.gp_resgroup_config
	WHERE groupname='rg_test_group';

-- ----------------------------------------------------------------------
-- Test: create/alter/drop a resource group in transaction block
-- ----------------------------------------------------------------------

-- CREATE RESOURCE GROUP cannot run inside a transaction block
BEGIN;
	CREATE RESOURCE GROUP rg_test_group WITH (cpu_rate_limit=5, memory_limit=5);
END;
SELECT * from rg_test_monitor;

-- ALTER RESOURCE GROUP cannot run inside a transaction block
CREATE RESOURCE GROUP rg_test_group WITH (cpu_rate_limit=5, memory_limit=5);
BEGIN;
	ALTER RESOURCE GROUP rg_test_group SET CONCURRENCY 10;
END;
SELECT * from rg_test_monitor;

-- DROP RESOURCE GROUP cannot run inside a transaction block
BEGIN;
	DROP RESOURCE GROUP rg_test_group;
END;
SELECT * from rg_test_monitor;

DROP RESOURCE GROUP rg_test_group;


-- ----------------------------------------------------------------------
-- Test: create/alter/drop a resource group and DML in transaction block
-- ----------------------------------------------------------------------

-- CREATE RESOURCE GROUP cannot run inside a transaction block
BEGIN;
	SELECT 1;
	CREATE RESOURCE GROUP rg_test_group WITH (cpu_rate_limit=5, memory_limit=5);
END;
SELECT * from rg_test_monitor;

-- ALTER RESOURCE GROUP cannot run inside a transaction block
CREATE RESOURCE GROUP rg_test_group WITH (cpu_rate_limit=5, memory_limit=5);
BEGIN;
	SELECT 1;
	ALTER RESOURCE GROUP rg_test_group SET CONCURRENCY 10;
END;
SELECT * from rg_test_monitor;

-- DROP RESOURCE GROUP cannot run inside a transaction block
BEGIN;
	SELECT 1;
	DROP RESOURCE GROUP rg_test_group;
END;
SELECT * from rg_test_monitor;

DROP RESOURCE GROUP rg_test_group;


-- ----------------------------------------------------------------------
-- Test: create/alter/drop a resource group in subtransaction
-- ----------------------------------------------------------------------

-- CREATE RESOURCE GROUP cannot run inside a subtransaction
BEGIN;
	SAVEPOINT rg_savepoint;
	CREATE RESOURCE GROUP rg_test_group WITH (cpu_rate_limit=5, memory_limit=5);
	ROLLBACK TO SAVEPOINT rg_savepoint;
ABORT;
SELECT * from rg_test_monitor;

-- ALTER RESOURCE GROUP cannot run inside a subtransaction
CREATE RESOURCE GROUP rg_test_group WITH (cpu_rate_limit=5, memory_limit=5);
BEGIN;
	SAVEPOINT rg_savepoint;
	ALTER RESOURCE GROUP rg_test_group SET CONCURRENCY 10;
	ROLLBACK TO SAVEPOINT rg_savepoint;
ABORT;
SELECT * from rg_test_monitor;

-- DROP RESOURCE GROUP cannot run inside a subtransaction
BEGIN;
	SAVEPOINT rg_savepoint;
	DROP RESOURCE GROUP rg_test_group;
	ROLLBACK TO SAVEPOINT rg_savepoint;
ABORT;
SELECT * from rg_test_monitor;

DROP RESOURCE GROUP rg_test_group;

-- cleanup
DROP VIEW rg_test_monitor;
