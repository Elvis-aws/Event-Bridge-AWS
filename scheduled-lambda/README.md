# Amazon EventBridge Scheduled to AWS Lambda
This template deploys a Lambda function that is triggered by an EventBridge Schedule. In this example, the Lambda 
function logs text to the console every minute.


## Deployment Instructions
- cd scheduled-lambda
- sam build
- sam deploy --guided

## How it works
This SAM template creates a Lambda function that logs `Hello World` to the console every minute.

## Testing
After running `sam deploy`, go to the Lambda console. Find your Lambda function, and open the CloudWatch logs. 
You will see the new events every minute.
