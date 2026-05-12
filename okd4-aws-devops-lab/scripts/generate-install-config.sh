#!/bin/bash

set -euo pipefail

PROJECT_ROOT=$(cd "$(dirname "$0")/.." && pwd)

SSH_KEY_FILE="${PROJECT_ROOT}/ssh/id_rsa.pub"
PULL_SECRET_FILE="${PROJECT_ROOT}/okd/pull-secret.txt"

TEMPLATE_FILE="${PROJECT_ROOT}/okd/install-config.yaml.tpl"
OUTPUT_FILE="${PROJECT_ROOT}/okd/install-config.yaml"

echo "[INFO] Reading SSH public key..."

if [[ ! -f "${SSH_KEY_FILE}" ]]; then
  echo "[ERROR] SSH public key not found:"
  echo "${SSH_KEY_FILE}"
  exit 1
fi

SSH_PUBLIC_KEY=$(cat "${SSH_KEY_FILE}")

echo "[INFO] Reading pull secret..."

if [[ ! -f "${PULL_SECRET_FILE}" ]]; then
  echo "[ERROR] Pull secret file not found:"
  echo "${PULL_SECRET_FILE}"
  exit 1
fi

PULL_SECRET=$(tr -d '\n' < "${PULL_SECRET_FILE}")

echo "[INFO] Generating install-config.yaml..."

cat > "${OUTPUT_FILE}" <<EOF
apiVersion: v1

baseDomain: devops-labs.io

metadata:
  name: okd

compute:
  - name: worker
    replicas: 2

controlPlane:
  name: master
  replicas: 1

networking:
  networkType: OVNKubernetes

  clusterNetwork:
    - cidr: 10.128.0.0/14
      hostPrefix: 23

  serviceNetwork:
    - 172.30.0.0/16

platform:
  aws:
    region: us-east-1

pullSecret: >
  ${PULL_SECRET}

sshKey: >
  ${SSH_PUBLIC_KEY}
EOF

echo "[INFO] install-config.yaml generated successfully"