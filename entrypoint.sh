#!/bin/bash
set -e

rm -f /app/tmp/pids/server.pid

bin/rails db:prepare
bin/rails db:seed
bin/rails css:install:tailwind
bin/rails assets:precompile

exec "$@"
