#!/bin/bash
set -eox pipefail

CWDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "${CWDIR}/common.bash"

SRCDIR=/home/gpadmin/gpdb_src

cat > ~/gpdb-env.sh << EOF
  source /usr/local/greenplum-db-devel/greenplum_path.sh
  export PGPORT=5432
  export MASTER_DATA_DIRECTORY=/data/gpdata/master/gpseg-1

  alias mdd='cd \$MASTER_DATA_DIRECTORY'
EOF
source ~/gpdb-env.sh

createdb gpadmin

trap look4diffs ERR
function look4diffs() {

    diff_files=\`find .. -name regression.diffs\`

    for diff_file in \${diff_files}; do
	if [ -f "\${diff_file}" ]; then
	    cat <<-FEOF

				======================================================================
				DIFF FILE: \${diff_file}
				----------------------------------------------------------------------

				\$(cat "\${diff_file}")

			FEOF
	fi
    done
    exit 1
}

cd ${SRCDIR}
configure
make ${MAKR_TEST_COMMAND}
