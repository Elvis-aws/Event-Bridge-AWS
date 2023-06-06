# Using Amazon EventBridge to route to API Destinations targets
With the new [API destinations feature]. EventBridge can now integrate with services outside of AWS using REST API calls.
This patterns configures an EventRule rule that routes to an API Destinations target. It configures a Connection, which 
contains the authorization for the API endpoint, and the API, which contains the URL, http method, and other configuration 
information.

## Deployment Instructions
- cd eventbridge-api-destinations
- sam build
- sam deploy --guided



## Testing

1. From a command line in this directory, send a test event to EventBridge simulating a "Payment failed" event:
```
aws events put-events --entries file://testEvent.json
```
2. In the Webhook.site example, the API call appears in the dashboard.
3. In the Slack example, a message appears in the specified Slack channel ("Payment failed").
4. For the sumo logic example use the testEvent.json within the 3-sumologic directory
5. For the mongoDB example use the testEvent.json within the 4-mongodb directory
6. For the zendesk example use the testEvent.json within the 5-zendesk directory
7. For the freshdesk example use the testEvent.json within the 6-freshdesk directory
8. For the datadog example use the testEvent.json within the 7-datadog directory
9. For the shopify example use the testEvent.json within the 9-shopify directory
```
aws events put-events --entries file://3-sumologic/testEvent.json
```

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
