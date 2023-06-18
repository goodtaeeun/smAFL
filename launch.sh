#!/bin/bash

PROJECT_HOME="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
yMAKE_HOME="$PROJECT_HOME/smake"

docker run --rm -it --privileged --memory=4g -v$SMAKE_HOME:/smake smafl
