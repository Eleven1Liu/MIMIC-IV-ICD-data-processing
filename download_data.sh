#!/bin/bash

MIMIC_3_DIR='./mimicdata/physionet.org/files/mimiciii/1.4'
MIMIC_4_DIR='./mimicdata/physionet.org/files/mimiciv/2.2'

USERNAME=$1
stty -echo # disable bash output
echo "Please enter your password: "
read passwd
stty echo # enable bash output

# Download and unzip MIMIC data
cd mimicdata
wget -r -N -c -np --user $USERNAME --password $passwd https://physionet.org/files/mimiciv/2.2/hosp/procedures_icd.csv.gz
wget -r -N -c -np --user $USERNAME --password $passwd https://physionet.org/files/mimiciv/2.2/hosp/diagnoses_icd.csv.gz
wget -r -N -c -np --user $USERNAME --password $passwd https://physionet.org/files/mimiciii/1.4/NOTEEVENTS.csv.gz

gzip -d "${MIMIC_3_DIR}/*.gz"
gzip -d "${MIMIC_4_DIR}/*.gz"

# Move note event to `MIMIC_4_dir/note`
mkdir -p "${MIMIC_4_DIR}/note" 
mv "${MIMIC_3_DIR}/NOTEEVENTS.csv" "${MIMIC_4_DIR}/note/discharge.csv"
echo "Move ${MIMIC_3_DIR}/NOTEEVENTS.csv to ${MIMIC_4_DIR}/note/discharge.csv"
