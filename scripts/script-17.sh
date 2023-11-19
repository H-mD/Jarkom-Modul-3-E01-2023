#!/bin/bash

endpoint_url="http://riegel.canyon.e01.com/api/me"
token_file="token.json"

token=$(jq -r '.token' "$token_file")

# Response Example
response=$(curl -s -H "Authorization: Bearer $token" http://riegel.canyon.e01.com/api/me)
echo " "
echo "response example:"
echo "$response"
echo " "

ab -n 100 -c 10 -H "Authorization: Bearer '$token'" "$endpoint_url"