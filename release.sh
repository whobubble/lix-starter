#!/bin/sh

cd web-client && yarn build --dest ../apps/engine_interface/priv/static/dist
git push gigalixir master