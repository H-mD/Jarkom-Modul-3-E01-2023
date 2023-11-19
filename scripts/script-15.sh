#!/bin/bash

register_url="http://riegel.canyon.e01.com/api/auth/register"
output_file="dummy.json"
cred_file="cred.json"

# Response Example
random_username=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 8 | head -n 1)
random_password=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 10 | head -n 1)

response=$(curl -s -X POST -H "Content-Type: application/json" -d '{"username": "'$random_username'","password": "'$random_password'"}' http://riegel.canyon.e01.com/api/auth/register)
echo " "
echo "response example:"
echo "$response"
echo " "
data="{\"username\": \"$random_username\", \"password\": \"$random_password\"}"
echo "$data" > "$cred_file"

# Load Testing
credentials=()
for i in {1..100}
do
    rand_username=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 8 | head -n 1)
    rand_password=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 10 | head -n 1)
    dataa="{\"username\": \"$rand_username\", \"password\": \"$rand_password\"}"
    credentials+=("$dataa")
done

echo "[" > $output_file
for ((i = 0; i < ${#credentials[@]}; i++))
do
    if [ $i -eq $((${#credentials[@]} - 1)) ]; then
        echo "${credentials[$i]}" >> $output_file
    else
        echo "${credentials[$i]}," >> $output_file
    fi
done
echo "]" >> $output_file

ab -n 100 -c 10 -p "$output_file" -T "application/json" http://riegel.canyon.e01.com/api/auth/register