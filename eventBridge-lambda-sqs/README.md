# Multiple Amazon EventBridge Buses to Multiple Amazon SNS Topics
This AWS SAM template deploys three EventBridge Buses, six EventBridge Rules (2 per Bus), four SNS Topics, three SQS 
queues and a Lambda function. 
The lambda function is an event generator which sends events to EventBridge Buses that trigger appropriate Rules 
sending the payload to the appropriate SNS Topic.  
SQS queues are attached to the Rules as Dead Letter Queues. 
Appropriate permissions are granted to EventBridge to trigger the SNS Topics and the Lambda function to put events 
in the EventBridge.

## Deployment Instructions
    ```
1. Change directory to the pattern directory:
    ```
    cd eventBridge-lambda-sqs
    ```
2. From the command line, use AWS SAM to deploy the AWS resources for the pattern as specified in the template.yml file:
    ```
    sam deploy --guided
    ```
3. During the prompts:
    * Enter a stack name
    * Enter the desired AWS Region
    * Allow SAM CLI to create IAM roles with the required permissions.

4. Note the outputs from the SAM deployment process. These contain the resource names and/or ARNs which are used for 
   testing.


## How it works
To make this easier to understand, we use an example.  
Countries report cross-border transactions to their respective Reserve/Central Bank.  
All banks have Transaction Warehouses where all transactions must be reported for every event.  
Transactions originate from bank branches or ATM (automatic teller machines) as subdomains (source) from all banks as 
events. For simplicity, we use three EventBridge Buses representing three banks (bluebank, redbank and greenbank).  
The "DetailType" is filtering for "transaction type" and the "Detail" section filters the "Yes/No" reportable field.  
Based on these combinations, events trigger different Rules and send transaction payloads to SNS Topics of the 
ReserveBank and/or the Transaction Warehouses of the respective bank's SNS Topics. The accompanying Lambda function 
will put events on the Buses to demonstrate this pattern.

## Testing

1. From the Cloud Formation Output, get the 4 SNS Topic ARNs and subscribe 4 email addresses to the SNS Topics using 
  this CLI command structure.
`aws sns subscribe --topic-arn ENTER_YOUR_TOPIC_ARN --protocol email --notification-endpoint ENTER_YOUR_EMAIL_ADDRESS`
2. Click the confirmation link delivered to your emails to verify the endpoint.
3. Send an event to EventBridge using the Lambda function:
- Get the 3 ARNs of the EventBridge Buses from the Cloud 
Formation Output.
- Open the Lambda function code in your Lambda console and replace "bus_a", "bus_b" and "bus_c" with the ARNs of the 
  Buses created the SAM template.
- Deploy the function and "Test" on the Console
- Alternatively, get the function name from the Cloud Formation Output and use the following CLI command to invoke the 
  function a few times:

`aws lambda invoke --function-name <<your function name>> 
response.json`

4. The function will randomly choose any of the 3 Buses and send an event.  The events will be classified "reportable" 
   or "non-reportable".  All "reportable" events trigger notification with the payload to the "ReserveBank SNS Topic" 
   and another notification to the appropriate Bank Warehouse matching the Bus selected.  All "non-reportable" events 
   do not trigger the ReserveBank SNS Topic but trigger the respective Bank Warehouse matching the Bus selected.

Consider this test successful if the email address subscribed to the "ReserveBank SNS Topic" receives all notifications 
for all "reportable" transactions regardless of the Source/Bank.  Secondly, each bank's Transaction Warehouses' SNS 
Topic should receive only a copy of all their transactions.

## Cleanup

1. Delete the stack
    ```bash
    aws cloudformation delete-stack --stack-name STACK_NAME
    ```
2. Confirm the stack has been deleted
    ```bash
    aws cloudformation list-stacks --query
    ```
----
Copyright 2022 Amazon.com, Inc. or its affiliates. All Rights Reserved.

SPDX-License-Identifier: MIT-0
