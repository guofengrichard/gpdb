/*-------------------------------------------------------------------------
 *
 * resource_manager.c
 *	  GPDB resource manager code.
 *
 *
 * Copyright (c) 2006-2017, Greenplum inc.
 *
 *
 -------------------------------------------------------------------------
 */
#include "postgres.h"

#include "cdb/cdbvars.h"
#include "cdb/memquota.h"
#include "utils/guc.h"
#include "utils/resource_manager.h"

/*
 * GUC variables.
 */
bool	ResourceScheduler = false;						/* Is scheduling enabled? */
ResourceManagerPolicy Gp_resource_manager_policy;

bool
IsResQueueEnabled(void)
{
	return ResourceScheduler &&
		Gp_resource_manager_policy == RESOURCE_MANAGER_POLICY_QUEUE;
}

bool
IsResGroupEnabled(void)
{
	return ResourceScheduler &&
		Gp_resource_manager_policy == RESOURCE_MANAGER_POLICY_GROUP;
}

void
InitResManager(void)
{
	if (Gp_role != GP_ROLE_DISPATCH)
		return;

	if (IsResQueueEnabled())
	{
		InitResScheduler();
		InitResPortalIncrementHash();
		gp_resmanager_memory_policy = gp_resqueue_memory_policy;
		gp_log_resmanager_memory = gp_log_resqueue_memory;
		gp_resmanager_print_operator_memory_limits = gp_resqueue_print_operator_memory_limits;
		gp_resmanager_memory_policy_auto_fixed_mem = gp_resqueue_memory_policy_auto_fixed_mem;
	}
	else if (IsResGroupEnabled() && !IsUnderPostmaster)
	{
		ResGroupControlInit();
	}
	else
	{
		gp_resmanager_memory_policy = RESMANAGER_MEMORY_POLICY_NONE;
	}
}
