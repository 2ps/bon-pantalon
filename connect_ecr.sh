#!/bin/bash
dir=$(dirname "${0}")
echo "Usage:  source ${dir}/${0}"
printf "Querying aws for username........."
username=$(aws iam get-user --query 'User.UserName' --output text)
printf "\e[34m${username}\e[0m\n"
printf "Querying aws for account alias...."
account=$(aws iam list-account-aliases --query 'AccountAliases' --output text)
printf "\e[34m${account}\e[0m\n"
echo "Logging into ${account} ecr as ${username}"
eval $(aws ecr get-login --no-include-email)
