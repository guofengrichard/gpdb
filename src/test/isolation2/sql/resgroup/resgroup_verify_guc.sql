-- start_ignore
! gpconfig -c max_statement_mem -v 20GB
! gpconfig -c statement_mem -v 10GB
! gpconfig -c max_resource_groups -v 80;
! gpconfig -c max_connections -v 100 -m 40;
! gpstop -rai;
-- end_ignore

show max_statement_mem;
show statement_mem;
show max_resource_groups;
show max_connections;
