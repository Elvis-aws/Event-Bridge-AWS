# Enrich EventBridge Pipes source data with API destinations

This pattern shows how to use EventBridge Pipes to enrich messages data coming from SQS Queue using API destinations

## Deployment Instructions
1. Change directory to the pattern directory:
    ```
    cd eventbridge-pipes-sqs-enrich-api-destination
    ```
2. From the command line, use AWS SAM to deploy the AWS resources for the pattern as specified in the template.yml file:
    ```
    sam deploy --guided
    ```
3. During the prompts:
    * Enter a stack name
    * Enter the desired AWS Region
    * Allow SAM CLI to create IAM roles with the required permissions.

4. Note the outputs from the SAM deployment process. These contain the resource names and/or ARNs which are 
   used for testing.

## How it works

EventBridge Pipes polls for messages from the SQS queue, EventBridge pipe enriches message data using an API 
destination. For our use case, the body of the SQS message has a US zip code, and EventBridge Pipe extracts the zip 
code from the message and sends it as a path parameter to the API destination. API returns additional details about the 
zip code as a response. EventBridge Pipe receives a response from the API destination and sends it to a target of 
Cloudwatch Logs.

## Testing

Provide steps to trigger the integration and show what should be observed if successful.

1. Stream logs from StepFunctions LogGroup 

```
sam logs --cw-log-group <LogGroup Name> --tail
```

2. Put a message into the queue

```
aws sqs send-message --queue-url ENTER_YOUR_SQS_QUEUE_URL --message-body file://event.json
```

3. Observe the logs for the new execution.

## Cleanup
 
1. Delete the stack
    ```bash
    sam delete
    ```

----
Copyright 2022 Amazon.com, Inc. or its affiliates. All Rights Reserved.

SPDX-License-Identifier: MIT-0
