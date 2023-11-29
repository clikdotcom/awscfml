# SQS

## Queue names

NB where queue name is used, you only need the name. You don't need the account number e.g. where it say 

```
@queueName Required string. The name of the queue (e.g. "123456789/my-sqs-queue").
```

### FIFO queue names

All FIFO queues require the name to end with `.fifo`. It will be appended if you don't add it when you use `createQueue`.

You only need `my-sqs-queue`

## Message visibility

Once you recieve a message, it is no longer "visible" for the visibility timeout of the queue. If it doesn't get deleted, it will reappear in the queue after that time.

The default is 30 seconds which is usually more than long enough. It can be specified for a queue with `visibilityTimeout` when creating the queue.