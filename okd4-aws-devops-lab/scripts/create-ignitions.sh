#!/bin/bash

set -e

PROJECT_ROOT=$(cd "$(dirname "$0")/.." && pwd)

OKD_DIR=${PROJECT_ROOT}/okd

INSTALL_DIR=${OKD_DIR}/install

IGNITION_DIR=${OKD_DIR}/ignition

mkdir -p ${IGNITION_DIR}

echo "[INFO] Creating ignition configs..."

cd ${OKD_DIR}

./binaries/openshift-install \
create ignition-configs \
--dir "${INSTALL_DIR}" \
--log-level=debug

echo "[INFO] Copying ignition files..."

cp ${INSTALL_DIR}/*.ign ${IGNITION_DIR}/

echo "[INFO] Ignition files generated successfully"

echo
echo "[INFO] Generated ignition files:"
ls -lh ${IGNITION_DIR}