#!/bin/bash
# Automation script for CloudFormation templates. 
#
# Parameters
#   $1: Execution mode. Valid values: deploy, delete, preview.
#   $2: AWS region.
#   $3: Stack name.
#   $4: Template file (optional).
#   $5: Parameter file (optional).
#
# Usage examples:
#   ./run.sh deploy us-east-1 my-stack (will use template.yml and template-parameters.json as default)
#   ./run.sh deploy us-east-1 my-stack template.yml (will use template-parameters.json as default)
#   ./run.sh deploy us-east-1 my-stack template.yml parameters.json
#   ./run.sh preview us-east-1 preview-stack (will use template.yml as default)
#   ./run.sh preview us-east-1 preview-stack custom-template.yml
#   ./run.sh delete us-east-1 my-stack

# Validate parameters
if [[ $1 != "deploy" && $1 != "delete" && $1 != "preview" ]]; then
    echo "ERROR: Incorrect execution mode. Valid values: deploy, delete, preview." >&2
    exit 1
fi

if [ -z "$2" ]; then
    echo "ERROR: AWS region is required as the second parameter." >&2
    exit 1
fi

if [ -z "$3" ]; then
    echo "ERROR: Stack name is required as the third parameter." >&2
    exit 1
fi

if [ "$1" == "deploy" ]; then
    if [ -z "$4" ]; then
        template_file="template.yml"
    else
        template_file="$4"
    fi

    if [ -z "$5" ]; then
        parameter_file="template-parameters.json"
    else
        parameter_file="$5"
    fi

    if [ ! -f "$template_file" ]; then
        echo "ERROR: Template file '$template_file' not found." >&2
        exit 1
    fi

    if [ ! -f "$parameter_file" ]; then
        echo "ERROR: Parameter file '$parameter_file' not found." >&2
        exit 1
    fi

    aws cloudformation deploy \
        --stack-name "$3" \
        --template-file "$template_file" \
        --parameter-overrides "$(cat "$parameter_file")" \
        --capabilities "CAPABILITY_IAM" "CAPABILITY_NAMED_IAM" \
        --region "$2"

elif [ "$1" == "delete" ]; then
    aws cloudformation delete-stack --stack-name "$3" --region "$2"

elif [ "$1" == "preview" ]; then
    if [ -z "$4" ]; then
        template_file="template.yml"
    else
        template_file="$4"
    fi

    if [ ! -f "$template_file" ]; then
        echo "ERROR: Template file '$template_file' not found." >&2
        exit 1
    fi

    aws cloudformation deploy \
        --stack-name "$3" \
        --template-file "$template_file" \
        --region "$2" \
        --no-execute-changeset

else
    echo "ERROR: Unhandled execution mode." >&2
    exit 1
fi
