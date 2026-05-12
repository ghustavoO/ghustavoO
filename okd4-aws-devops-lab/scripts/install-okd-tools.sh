#!/bin/bash
set -euo pipefail

OKD_VERSION="4.18.0-okd-scos.6"

PROJECT_ROOT=$(cd "$(dirname "$0")/.." && pwd)
BIN_DIR="${PROJECT_ROOT}/okd/binaries"

mkdir -p "${BIN_DIR}"
cd "${BIN_DIR}"

RELEASE_IMAGE="registry.ci.openshift.org/origin/release-scos:${OKD_VERSION}"

echo "[INFO] Using release image:"
echo "${RELEASE_IMAGE}"

echo "[INFO] Extracting openshift-install..."

oc adm release extract \
  --command=openshift-install \
  "${RELEASE_IMAGE}"

echo "[INFO] Extracting oc..."

oc adm release extract \
  --command=oc \
  "${RELEASE_IMAGE}"

echo "[INFO] Skipping kubectl (not provided in SCOS release image)"

chmod +x openshift-install oc

# kubectl fallback (link ao oc)
ln -sf oc kubectl

echo "[INFO] OKD tools ready"