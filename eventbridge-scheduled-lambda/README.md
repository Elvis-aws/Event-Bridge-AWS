# Amazon EventBridge Scheduled to AWS Lambda

This template deploys a Lambda function that is triggered by an EventBridge Schedule. In this example, the Lambda 
function logs text to the console every minute.
## Deployment Instructions
1. Change directory to the pattern directory:
    ```
    cd eventbridge-scheduled-lambda
    ```
1. From the command line, use AWS SAM to deploy the AWS resources for the pattern as specified in the template.yml file:
    ```
    sam deploy --guided
    ```
1. During the prompts:
    * Enter a stack name
    * Enter the desired AWS Region
    * Allow SAM CLI to create IAM roles with the required permissions.

## How it works

This SAM template creates a Lambda function that logs `Hello World` to the console every minute.

## Testing

After running `sam deploy`, go to the Lambda console. Find your Lambda function, and open the CloudWatch logs. 
You will see the new events every minute.

## Cleanup
 
1. Delete the stack
    ```bash
    aws cloudformation delete-stack --stack-name STACK_NAME
    ```
1. Confirm the stack has been deleted
    ```bash
    aws cloudformation list-stacks --query "StackSummaries[?contains(StackName,'STACK_NAME')].StackStatus"
    ```
----
Copyright 2021 Amazon.com, Inc. or its affiliates. All Rights Reserved.

SPDX-License-Identifier: MIT-0
