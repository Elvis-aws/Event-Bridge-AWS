# Webhook

## Deployment Instructions
- cd eventbridge-api-destinations
- cd 1-webhook-site
- sam build
- sam deploy --guided

## Testing
- Navigate to https://webhook.site
- Copy Your unique URL
- From a command line in this directory, send a test event to EventBridge simulating a "Payment failed" event:
```
aws events put-events --entries file://testEvent.json
```
- In the Webhook.site example, the API call appears in the dashboard.

