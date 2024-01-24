#!/bin/bash

# ANSI color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to list and select AWS profiles
select_aws_profile() {
    echo -e "${BLUE}AWS_PROFILE not set. Listing available profiles...${NC}"
    profiles_config=$(awk '/^\[/{gsub(/\[|\]/,"");print}' ~/.aws/config | sed 's/^profile //')
    profiles_credentials=$(awk '/^\[/{gsub(/\[|\]/,"");print}' ~/.aws/credentials)
    profiles=$(echo -e "$profiles_config\n$profiles_credentials" | sort -u)
    selected_profile=$(echo "$profiles" | fzf --height 20% --header "Select an AWS Profile")

    if [[ ! -z "$selected_profile" ]]; then
        export AWS_PROFILE=$selected_profile
        echo -e "${GREEN}Selected AWS profile: $AWS_PROFILE${NC}"
    else
        echo -e "${RED}No profile selected. Exiting.${NC}"
        exit 1
    fi
}

# The rest of the script for listing and connecting to EC2 instances
instances=$(aws ec2 describe-instances \
            --query "Reservations[*].Instances[*].[InstanceId, Tags[?Key=='Name'].Value | [0]]" \
            --output json | jq -r '.[][] | @csv')

if [[ -z "$instances" ]]; then
    echo -e "${RED}No instances found.${NC}"
    exit 1
fi

selected_instance=$(echo "$instances" | tr -d '"' | fzf --height 20% --header "Select an Instance" --delimiter ',' --with-nth 2)
instance_id=$(echo $selected_instance | cut -d ',' -f1)

if [[ ! -z "$instance_id" ]]; then
    aws ssm start-session --target "$instance_id"
else
    echo -e "${RED}No instance selected.${NC}"
fi

