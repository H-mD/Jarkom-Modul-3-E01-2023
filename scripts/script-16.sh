#!/bin/bash

login_url="http://riegel.canyon.e01.com/api/auth/login"
json_file="cred.json"
token_file="token.json"

# Response Example
username=$(jq -r '.username' "$json_file")
password=$(jq -r '.password' "$json_file")
response=$(curl -s -X POST -H "Content-Type: application/json" -d '{"username": "'$username'","password": "'$password'"}' http://riegel.canyon.e01.com/api/auth/login)
echo " "
echo "response example:"
echo "$response"
echo " "

echo "$response" > "$token_file"

ab -n 100 -c 10 -p "$json_file" -T "application/json" http://riegel.canyon.e01.com/api/auth/login