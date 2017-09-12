/*-------------------------------------------------------------------------
 *
 * instrument.c
 *	 functions for instrumentation of plan execution
 *
 *
 * Portions Copyright (c) 2006-2009, Greenplum inc
 * Portions Copyright (c) 2012-Present Pivotal Software, Inc.
 * Copyright (c) 2001-2009, PostgreSQL Global Development Group
 *
 * IDENTIFICATION
 *	  $PostgreSQL: pgsql/src/backend/executor/instrument.c,v 1.20 2008/01/01 19:45:49 momjian Exp $
 *
 *-------------------------------------------------------------------------
 */
#include "postgres.h"

#include <unistd.h>

#include "storage/shmem.h"
#include "storage/spin.h"
#include "executor/instrument.h"

Statistics *StatisticsGlobal = NULL;

/* Allocate new instrumentation structure(s) */
Instrumentation *
InstrAlloc(int n)
{
	Instrumentation *instr = palloc0(n * sizeof(Instrumentation));

	/* we don't need to do any initialization except zero 'em */
	instr->numPartScanned = 0;

	return instr;
}

/* Entry to a plan node */
void
InstrStartNode(Instrumentation *instr)
{
	if (INSTR_TIME_IS_ZERO(instr->starttime))
		INSTR_TIME_SET_CURRENT(instr->starttime);
	else
		elog(DEBUG2, "InstrStartNode called twice in a row");
}

/* Exit from a plan node */
void
InstrStopNode(Instrumentation *instr, double nTuples)
{
	instr_time	endtime;

	/* count the returned tuples */
	instr->tuplecount += nTuples;

	if (INSTR_TIME_IS_ZERO(instr->starttime))
	{
		elog(DEBUG2, "InstrStopNode called without start");
		return;
	}

	INSTR_TIME_SET_CURRENT(endtime);
	INSTR_TIME_ACCUM_DIFF(instr->counter, endtime, instr->starttime);

	/* Is this the first tuple of this cycle? */
	if (!instr->running)
	{
		instr->running = true;
		instr->firsttuple = INSTR_TIME_GET_DOUBLE(instr->counter);
		/* CDB: save this start time as the first start */
		instr->firststart = instr->starttime;
	}

	INSTR_TIME_SET_ZERO(instr->starttime);
}

/* Finish a run cycle for a plan node */
void
InstrEndLoop(Instrumentation *instr)
{
	double		totaltime;

	/* Skip if nothing has happened, or already shut down */
	if (!instr->running)
		return;

	if (!INSTR_TIME_IS_ZERO(instr->starttime))
		elog(DEBUG2, "InstrEndLoop called on running node");

	/* Accumulate per-cycle statistics into totals */
	totaltime = INSTR_TIME_GET_DOUBLE(instr->counter);

	/* CDB: Report startup time from only the first cycle. */
	if (instr->nloops == 0)
		instr->startup = instr->firsttuple;

	instr->total += totaltime;
	instr->ntuples += instr->tuplecount;
	instr->nloops += 1;

	/* Reset for next cycle (if any) */
	instr->running = false;
	INSTR_TIME_SET_ZERO(instr->starttime);
	INSTR_TIME_SET_ZERO(instr->counter);
	instr->firsttuple = 0;
	instr->tuplecount = 0;
}

inline void
StatisticsStopNode(Statistics *stat, int nTuples)
{
	stat->stats.tuplecount += nTuples;
	if (!stat->stats.running) {
		stat->stats.running = true;
		instr_time	endtime;
		INSTR_TIME_SET_CURRENT(endtime);
		stat->stats.firsttuple = INSTR_TIME_GET_DOUBLE(endtime);
	}
}

inline void
StatisticsEndLoop(Statistics *stat)
{
	stat->stats.ntuples += stat->stats.tuplecount;
	stat->stats.nloops += 1;
	stat->stats.tuplecount = 0;
}
//inline void
//StatisticsSetNext(Statistics *stat, Statistics *value)
//{
//	Statistics **next;

//	next = (Statistics **) stat + sizeof(Statistics) - sizeof(void *);
//	next = (void * Statistic *)(stat + 1) - 1;
//	GetStatisticsNext(stat) = value;
//}

//inline Statistics *
//StatisticsGetNext(Statistics *stat)
//{
//	Statistics **next;

//	next = (void * Statistic *)(stat + 1) - 1;
//	return GetStatisticsNext(stat);
//}

Size
StatisticsShmemSize(void)
{
	return MaxPlanNodes * sizeof (Statistics);
}

void
StatisticsShmemInit(void)
{
	Size size = StatisticsShmemSize();
	Statistics *stats;
	int i;

	stats = (Statistics *)ShmemAlloc(size);
	if (!stats)
		ereport(FATAL,
				(errcode(ERRCODE_OUT_OF_MEMORY),
				 errmsg("out of shared memory")));
	MemSet(stats, 0, size);

	stats[0].header.head = &stats[1];
	stats[0].header.in_use = 0;
	stats[0].header.free = MaxPlanNodes - 1;
	SpinLockInit(&stats[0].header.stat_lck);

	for (i = 1; i < MaxPlanNodes - 1; i++)
		GetStatisticsNext(&stats[i]) = &stats[i + 1];
	GetStatisticsNext(&stats[i]) = NULL;

	StatisticsGlobal = stats;
}

Statistics *
StatisticsAlloc(void)
{
	Statistics *stat;

	SpinLockAcquire(&StatisticsGlobal->header.stat_lck);
	stat = (Statistics *)StatisticsGlobal->header.head;
	if (stat != NULL)
	{
		StatisticsGlobal->header.head = GetStatisticsNext(stat);
		StatisticsGlobal->header.free--;
		StatisticsGlobal->header.in_use++;
	}
	SpinLockRelease(&StatisticsGlobal->header.stat_lck);

	if (stat != NULL)
		GetStatisticsNext(stat) = NULL;

	return stat;
}

void
StatisticsFree(Statistics *stat)
{
	if (stat == NULL)
		return;

	MemSet(stat, 0, sizeof(Statistics));

	SpinLockAcquire(&StatisticsGlobal->header.stat_lck);

	GetStatisticsNext(stat) =  StatisticsGlobal->header.head;
	StatisticsGlobal->header.head = stat;
	StatisticsGlobal->header.free++;
	StatisticsGlobal->header.in_use--;

	SpinLockRelease(&StatisticsGlobal->header.stat_lck);
}
