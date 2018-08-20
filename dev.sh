#!/bin/sh

iex -S mix phx.server

cd web-client
yarn serve