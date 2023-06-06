# Run application
    # virtualenv env
    # source env/bin/activate
    # pip3 install -r requirements.txt
    # pip3 freeze > requirements.txt

# Multiple Amazon EventBridge Buses to Multiple Amazon SNS Topics
This AWS SAM template deploys three EventBridge Buses, six EventBridge Rules (2 per Bus), four SNS Topics, three SQS 
queues and a Lambda function. The lambda function is an event generator which sends events to EventBridge Buses that 
trigger appropriate Rules sending the payload to the appropriate SNS Topic. SQS queues are attached to the Rules as 
Dead Letter Queues. Appropriate permissions are granted to EventBridge to trigger the SNS Topics and the Lambda function 
to put events in the EventBridge.

## Deployment Instructions
- cd cd eventBridge-lambda-sqs
- sam build
- sam deploy --guided
- Outputs from the SAM deployment process contain the resource names and/or ARNs which are used for testing.

## How it works
To make this easier to understand, we use an example. Countries report cross-border transactions to their respective 
Reserve/Central Bank. All banks have Transaction Warehouses where all transactions must be reported for every event.  
Transactions originate from bank branches or ATM (automatic teller machines) as subdomains (source) from all banks as 
events. For simplicity, we use three EventBridge Buses representing three banks (bluebank, redbank and greenbank).  
The "DetailType" is filtering for "transaction type" and the "Detail" section filters the "Yes/No" reportable field.  
Based on these combinations, events trigger different Rules and send transaction payloads to SNS Topics of the 
ReserveBank and/or the Transaction Warehouses of the respective bank's SNS Topics. The accompanying Lambda function 
will put events on the Buses to demonstrate this pattern.

## Testing

1. Get the 4 SNS Topic ARNs and subscribe 4 email addresses to the SNS Topics using 
  this CLI command structure.
`aws sns subscribe --topic-arn arn:aws:sns:eu-west-2:934433842270:event-bridge-app-BlueBankTopic-7mKJM3GBXFvY --protocol email --notification-endpoint ngwesseaws@gmail.com`
`aws sns subscribe --topic-arn arn:aws:sns:eu-west-2:934433842270:event-bridge-app-GreenBankTopic-ydpSDmmP0i7H --protocol email --notification-endpoint ngwesseaws@gmail.com`
`aws sns subscribe --topic-arn arn:aws:sns:eu-west-2:934433842270:event-bridge-app-RedBankTopic-PKjH22vkyFYD --protocol email --notification-endpoint ngwesseaws@gmail.com`
`aws sns subscribe --topic-arn arn:aws:sns:eu-west-2:934433842270:event-bridge-app-ReserveBankTopic-JU0BFERe6nOM --protocol email --notification-endpoint ngwesseaws@gmail.com`
2. Click the confirmation link delivered to your emails to verify the endpoint.
3. Send an event to EventBridge using the Lambda function:
`aws lambda invoke --function-name EventsGeneratorFunction response.json`

4. The function will randomly choose any of the 3 Buses and send an event.  The events will be classified "reportable" 
   or "non-reportable".  All "reportable" events trigger notification with the payload to the "ReserveBank SNS Topic" 
   and another notification to the appropriate Bank Warehouse matching the Bus selected.  All "non-reportable" events 
   do not trigger the ReserveBank SNS Topic but trigger the respective Bank Warehouse matching the Bus selected.

Consider this test successful if the email address subscribed to the "ReserveBank SNS Topic" receives all notifications 
for all "reportable" transactions regardless of the Source/Bank.  Secondly, each bank's Transaction Warehouses' SNS 
Topic should receive only a copy of all their transactions.
