#!/bin/bash

set -e

rm -f /EnigmaCraft/tmp/pids/server.pid

exec "$@"
