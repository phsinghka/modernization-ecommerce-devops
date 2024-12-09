#!/bin/bash

export KOPS_STATE_STORE="s3://phsinghka-kops-state"
export CONTROL_PLANE_SIZE="t2.medium"
export NODE_SIZE="t2.micro"
export ZONES="us-east-1a,us-east-1b,us-east-1c"

kops create cluster kube.codetocloud.online \
--node-count 3 \
--zones $ZONES \
--node-size $NODE_SIZE \
--control-plane-count 1 \
--control-plane-size $CONTROL_PLANE_SIZE \
--yes

# kops delete cluster kube.codetocloud.online --yes
