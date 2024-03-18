#!/bin/bash

MIMIC_DATA_DIR='./mimicdata/physionet.org/files'
MIMIC_4_DIR=${MIMIC_DATA_DIR}/mimiciv/2.2
# MIMIC_3_DIR=${MIMIC_DATA_DIR}/mimiciii/1.4

USERNAME=$1
stty -echo # disable bash output
echo "Please enter your password: "
read passwd
stty echo # enable bash output

# Download and unzip MIMIC data
cd mimicdata
wget -r -N -c -np --user $USERNAME --password $passwd https://physionet.org/files/mimiciv/2.2/hosp/procedures_icd.csv.gz
wget -r -N -c -np --user $USERNAME --password $passwd https://physionet.org/files/mimiciv/2.2/hosp/diagnoses_icd.csv.gz
wget -r -N -c -np --user $USERNAME --password $passwd https://physionet.org/files/mimic-iv-note/2.2/note/discharge.csv.gz
# wget -r -N -c -np --user $USERNAME --password $passwd https://physionet.org/files/mimiciii/1.4/NOTEEVENTS.csv.gz

no | gzip -d -r ${MIMIC_DATA_DIR}

# Move discharge summary to `MIMIC_4_DIR`/note
mkdir -p ${MIMIC_4_DIR}/note
mv ${MIMIC_DATA_DIR}/mimic-iv-note/2.2/note/discharge.csv ${MIMIC_4_DIR}/note
