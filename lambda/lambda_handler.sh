#!/bin/bash

# Read input from AWS Lambda event
input=$(jq -r '.roman' < /dev/stdin)

# Call the original program with the input
output=$(./roman "$input" 2>&1)

# Check for errors and format the response
if [[ $? -ne 0 ]]; then
    echo "{\"error\": \"$output\"}"
else
    echo "{\"result\": $output}"
fi
