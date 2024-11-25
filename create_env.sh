#!/bin/bash

cp secrets/credentials.txt srcs/.env

DB_PASSWORD_FILE=$(cat "secrets/db-root.txt")
echo "DB_ROOT=$DB_PASSWORD_FILE" >> srcs/.env

DB_PASSWORD_FILE=$(cat "secrets/db.txt")
echo "DB_PASS=$DB_PASSWORD_FILE" >> srcs/.env

DB_PASSWORD_FILE=$(cat "secrets/wp.txt")
echo "WP_USERPASS=$DB_PASSWORD_FILE" >> srcs/.env

DB_PASSWORD_FILE=$(cat "secrets/wpa.txt")
echo "ADM_WP_PASS=$DB_PASSWORD_FILE" >> srcs/.env

