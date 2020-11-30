#!/bin/bash

# make the bucket
aws s3 mb "s3://${PROJECT_NAME}"

# set CORS rules for the bucket
aws s3api put-bucket-cors \
    --bucket ${PROJECT_NAME} \
    --cors-configuration file://cors.json

source package.sh

# create the lambda function and upload packaged code
aws lambda create-function \
    --function-name ${PROJECT_NAME} \
    --zip-file fileb://package.zip \
    --handler function.lambda_handler \
    --runtime {{cookiecutter.python_runtime}} \
    --role ${AWS_LAMBDA_ROLE} \
    --timeout {{cookiecutter.lambda_timeout}} \
    > 'function.json'

rm package.zip

source set-env-vars.sh

source schedule.sh