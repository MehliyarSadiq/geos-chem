#!/bin/bash

#------------------------------------------------------------------------------
#                  GEOS-Chem Global Chemical Transport Model                  !
#------------------------------------------------------------------------------
#BOP
#
# !MODULE: createIntTests
#
# !DESCRIPTION: Creates integration test run directories in a user-specified
#  folder, and copies a run script there.
#\\
#\\
# !CALLING SEQUENCE:
#  ./createIntTests /path/to/integration/test/root/folder
#
# !REMARKS:
#  Right now we pass values to the existing ./createRunDir.sh,
#  but will implement a more elegant solution later.#
#
# !REVISION HISTORY:
#  09 Oct 2020 - R. Yantosca - Initial version
#  See the subsequent Git history with the gitk browser!
#EOP
#------------------------------------------------------------------------------
#BOC

# Check arguments
if [[ "x${1}" == "x" ]]; then
    echo "ERROR: The root-level directory for tests has not been specified!"
    exit
fi

# Define variables
GCC_RUN_DIR="../run/GCClassic"
GCHP_RUN_DIR="../run/GCHPctm"
THIS_DIR=`pwd -P`
TEST_ROOT=${1}

# sed string editor commands
SED_INPUT_GEOS="s/20190801 000000/20190701 002000/"
SED_HISTORY_RC="s/00000100 000000/00000000 002000/"

# Remove run directories in the test folder
for dir in ${TEST_ROOT}/*; do
    if [[ -d ${dir} ]]; then
	echo "Removing ${dir}"
	rm -rf ${dir}
    fi
done

# Copying the run script to the root test folder
cp -f ./runIntTests.sh ${TEST_ROOT}
mkdir ${TEST_ROOT}/logs

# Log file
LOG=${TEST_ROOT}/logs/createIntTests.log
rm -f ${LOG}

# Change to the directory where we will create the rundirs
cd $GCC_RUN_DIR

RUNDIR="gc_4x5_standard_merra2"
CMD="1\n1\n1\n1\n1\n${TEST_ROOT}\n${RUNDIR}\nn\n"
printf ${CMD} | ./createRunDir.sh >> ${LOG} 2>&1
sed -i -e "${SED_INPUT_GEOS}" ${TEST_ROOT}/${RUNDIR}/input.geos
sed -i -e "${SED_HISTORY_RC}" ${TEST_ROOT}/${RUNDIR}/HISTORY.rc

RUNDIR="gc_4x5_benchmark_merra2"
CMD="1\n1\n2\n1\n1\n${TEST_ROOT}\n${RUNDIR}\nn\n"
printf ${CMD} | ./createRunDir.sh >> ${LOG} 2>&1
sed -i -e "${SED_INPUT_GEOS}" ${TEST_ROOT}/${RUNDIR}/input.geos
sed -i -e "${SED_HISTORY_RC}" ${TEST_ROOT}/${RUNDIR}/HISTORY.rc

RUNDIR="gc_4x5_CH4_merra2"
CMD="3\n1\n1\n1\n${TEST_ROOT}\n${RUNDIR}\nn\n"
printf ${CMD} | ./createRunDir.sh >> ${LOG} 2>&1
sed -i -e "${SED_INPUT_GEOS}" ${TEST_ROOT}/${RUNDIR}/input.geos
sed -i -e "${SED_HISTORY_RC}" ${TEST_ROOT}/${RUNDIR}/HISTORY.rc

RUNDIR="gc_4x5_CO2_merra2"
CMD="4\n1\n1\n1\n${TEST_ROOT}\n${RUNDIR}\nn\n"
printf ${CMD} | ./createRunDir.sh >> ${LOG} 2>&1
sed -i -e "${SED_INPUT_GEOS}" ${TEST_ROOT}/${RUNDIR}/input.geos
sed -i -e "${SED_HISTORY_RC}" ${TEST_ROOT}/${RUNDIR}/HISTORY.rc

RUNDIR="gc_4x5_Hg_merra2"
CMD="5\n1\n1\n1\n${TEST_ROOT}\n${RUNDIR}\nn\n"
printf ${CMD} | ./createRunDir.sh >> ${LOG} 2>&1
sed -i -e "${SED_INPUT_GEOS}" ${TEST_ROOT}/${RUNDIR}/input.geos
sed -i -e "${SED_HISTORY_RC}" ${TEST_ROOT}/${RUNDIR}/HISTORY.rc

#RUNDIR="gc_4x5_POPs_merra2"
#CMD="6\n1\n1\n1\n${TEST_ROOT}\n${RUNDIR}\nn\n"
#printf ${CMD} | ./createRunDir.sh >> ${LOG} 2>&1
#sed -i -e "${SED_INPUT_GEOS}" ${TEST_ROOT}/${RUNDIR}/input.geos
#sed -i -e "${SED_HISTORY_RC}" ${TEST_ROOT}/${RUNDIR}/HISTORY.rc

RUNDIR="gc_4x5_tagCH4_merra2"
CMD="7\n1\n1\n1\n${TEST_ROOT}\n${RUNDIR}\nn\n"
printf ${CMD} | ./createRunDir.sh >> ${LOG} 2>&1
sed -i -e "${SED_INPUT_GEOS}" ${TEST_ROOT}/${RUNDIR}/input.geos
sed -i -e "${SED_HISTORY_RC}" ${TEST_ROOT}/${RUNDIR}/HISTORY.rc

RUNDIR="gc_4x5_tagCO_merra2"
CMD="8\n1\n1\n1\n${TEST_ROOT}\n${RUNDIR}\nn\n"
printf ${CMD} | ./createRunDir.sh >> ${LOG} 2>&1
sed -i -e "${SED_INPUT_GEOS}" ${TEST_ROOT}/${RUNDIR}/input.geos
sed -i -e "${SED_HISTORY_RC}" ${TEST_ROOT}/${RUNDIR}/HISTORY.rc

RUNDIR="gc_4x5_tagO3_merra2"
CMD="9\n1\n1\n1\n${TEST_ROOT}\n${RUNDIR}\nn\n"
printf ${CMD} | ./createRunDir.sh >> ${LOG} 2>&1
sed -i -e "${SED_INPUT_GEOS}" ${TEST_ROOT}/${RUNDIR}/input.geos
sed -i -e "${SED_HISTORY_RC}" ${TEST_ROOT}/${RUNDIR}/HISTORY.rc

RUNDIR="gc_4x5_TransportTracers_merra2"
CMD="10\n1\n1\n1\n${TEST_ROOT}\n${RUNDIR}\nn\n"
printf ${CMD} | ./createRunDir.sh >> ${LOG} 2>&1
sed -i -e "${SED_INPUT_GEOS}" ${TEST_ROOT}/${RUNDIR}/input.geos
sed -i -e "${SED_HISTORY_RC}" ${TEST_ROOT}/${RUNDIR}/HISTORY.rc



#RUNDIR="gc_4x5_geosfp_standard"
#CMD="1\n1\n1\n2\n1\n${TEST_ROOT}\n${rundir}\nn\n"
#printf ${CMD} | ./createRunDir.sh >> ${LOG} 2>&1
#sed -i -e "${SED_INPUT_GEOS}" ${TEST_ROOT}/${RUNDIR}/input.geos
#sed -i -e "${SED_HISTORY_RC}" ${TEST_ROOT}/${RUNDIR}/HISTORY.rc
#
#RUNDIR="gc_2x25_merra2_standard"
#CMD="1\n1\n1\n1\n2\n${TEST_ROOT}\n${rundir}\nn\n"
#printf ${CMD} | ./createRunDir.sh >> ${LOG} 2>&1
#sed -i -e "${SED_INPUT_GEOS}" ${TEST_ROOT}/${RUNDIR}/input.geos
#sed -i -e "${SED_HISTORY_RC}" ${TEST_ROOT}/${RUNDIR}/HISTORY.rc
#
#RUNDIR="gc_2x25_geosfp_standard"
#CMD="1\n1\n1\n2\n2\n${TEST_ROOT}\n${rundir}\nn\n"
#printf ${CMD} | ./createRunDir.sh >> ${LOG} 2>&1
#sed -i -e "${SED_INPUT_GEOS}" ${TEST_ROOT}/${RUNDIR}/input.geos
#sed -i -e "${SED_HISTORY_RC}" ${TEST_ROOT}/${RUNDIR}/HISTORY.rc
#
#RUNDIR="gc_4x5_merra2_standard"
#CMD="1\n1\n1\n1\n1\n${TEST_ROOT}\n${rundir}\nn\n"
#printf ${CMD} | ./createRunDir.sh >> ${LOG} 2>&1
#sed -i -e "${SED_INPUT_GEOS}" ${TEST_ROOT}/${RUNDIR}/input.geos
#sed -i -e "${SED_HISTORY_RC}" ${TEST_ROOT}/${RUNDIR}/HISTORY.rc

# Switch back to the present directory
cd ${THIS_DIR}
#EOC
