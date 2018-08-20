#!/bin/sh

cd web-client; and yarn build --dest ../apps/engine_interface/priv/static
cd apps/engine_interface; and env MIX_ENV=prod SECRET_KEY_BASE="oCu2cZMKj4g5/S7AILBlLhSSiXMR5yMGEO/fGmGbHoq1X3uDa1JUGRoHQaS0Tn1w" mix release --env=prod
env MIX_ENV=prod SECRET_KEY_BASE="oCu2cZMKj4g5/S7AILBlLhSSiXMR5yMGEO/fGmGbHoq1X3uDa1JUGRoHQaS0Tn1w" DATABASE_URL="postgresql://user:pass@localhost:5432/foo" MY_HOSTNAME=example.com MY_COOKIE=secret REPLACE_OS_VARS=true MY_NODE_NAME=foo@127.0.0.1 PORT=4000 /Users/stefant/code/lix-starter/_build/prod/rel/engine_interface/bin/engine_interface foreground