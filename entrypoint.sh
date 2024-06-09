#!/bin/bash
set -e

rm -f /app/tmp/pids/server.pid

bin/rails db:migrate
bin/rails assets:precompile

exec "$@"
