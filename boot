#!/bin/bash

case $1 in

  db:refresh)
    echo "about to rewrite db";
    dropdb --host=127.0.0.1 --port=5432 -e -U postgres cendana_db;
    createdb --host=127.0.0.1 --port=5432 -e -U postgres -O postgres cendana_db;
    ;;

  *)
    echo "unknown"
    ;;
esac
