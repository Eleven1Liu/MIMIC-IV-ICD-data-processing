#!/bin/bash

MIMIC_DATA_DIR='./mimicdata/physionet.org/files'
MIMIC_4_DIR=${MIMIC_DATA_DIR}/mimiciv/2.2
# MIMIC_3_DIR=${MIMIC_DATA_DIR}/mimiciii/1.4
FILES=("mimiciv/2.2/hosp/procedures_icd.csv" "mimiciv/2.2/hosp/diagnoses_icd.csv" "mimic-iv-note/2.2/note/discharge.csv")

USERNAME=$1
stty -echo # disable bash output
echo "Please enter your password: "
read passwd
stty echo # enable bash output

# Download and unzip MIMIC data
for file in "${FILES[@]}"; do
    if [ -f "${MIMIC_DATA_DIR}/$file" ]; then
        echo "$file exists. Skip"
    else
        echo "$file does not exist. Download from physionet."
        wget -r -N -c -np --user $USERNAME --password $passwd -P mimicdata https://physionet.org/files/$file.gz
    fi
done

find ./mimicdata/physionet.org/files/ -name "*.gz" -type f -exec gzip -d {} +

# Move discharge summary to `MIMIC_4_DIR`/note
mkdir -p ${MIMIC_4_DIR}/note
mv ${MIMIC_DATA_DIR}/mimic-iv-note/2.2/note/discharge.csv ${MIMIC_4_DIR}/note
