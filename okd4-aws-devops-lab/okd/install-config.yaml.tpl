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

pullSecret: |-
  ${pull_secret}

sshKey: |-
  ${ssh_public_key}
