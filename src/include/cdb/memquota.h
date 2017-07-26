/*-------------------------------------------------------------------------
 *
 * memquota.h
 * Routines related to memory quota for queries.
 *
 * Copyright (c) 2005-2010, Greenplum inc
 *-------------------------------------------------------------------------*/
#ifndef MEMQUOTA_H_
#define MEMQUOTA_H_

#include "nodes/plannodes.h"
#include "cdb/cdbplan.h"

typedef enum ResManagerMemoryPolicy
{
	RESMANAGER_MEMORY_POLICY_NONE,
	RESMANAGER_MEMORY_POLICY_AUTO,
	RESMANAGER_MEMORY_POLICY_EAGER_FREE
} ResManagerMemoryPolicy;

extern ResManagerMemoryPolicy gp_resmanager_memory_policy;
extern bool						gp_log_resmanager_memory;
extern int						gp_resmanager_memory_policy_auto_fixed_mem;
extern bool						gp_resmanager_print_operator_memory_limits;

#define GP_RESMANAGER_MEMORY_LOG_LEVEL NOTICE

extern void PolicyAutoAssignOperatorMemoryKB(PlannedStmt *stmt, uint64 memoryAvailable);
extern void PolicyEagerFreeAssignOperatorMemoryKB(PlannedStmt *stmt, uint64 memoryAvailable);

/**
 * Inverse for explain analyze.
 */
extern uint64 PolicyAutoStatementMemForNoSpillKB(PlannedStmt *stmt, uint64 minOperatorMemKB);

/**
 * Is result node memory intensive?
 */
extern bool IsResultMemoryIntesive(Result *res);

/*
 * Calculate the amount of memory reserved for the query
 */
extern int64 ResourceManagerGetQueryMemoryLimit(PlannedStmt* stmt);

#endif /* MEMQUOTA_H_ */
