#!/bin/bash

set -euo pipefail

PROJECT_ROOT=$(cd "$(dirname "$0")/.." && pwd)

OKD_DIR="${PROJECT_ROOT}/okd"
INSTALL_DIR="${OKD_DIR}/install"

rm -rf "${INSTALL_DIR}"

mkdir -p "${INSTALL_DIR}"

cp "${OKD_DIR}/install-config.yaml" "${INSTALL_DIR}/"

echo "[INFO] Creating manifests..."

"${OKD_DIR}/binaries/openshift-install" \
  create manifests \
  --dir "${INSTALL_DIR}" \
  --log-level=debug

echo "[INFO] Manifests generated successfully"