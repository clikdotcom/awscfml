<cfscript>
queueName = "testqueue5";

messages = request.prc.aws.sqs.receiveMessage(
        queueName=queueName,
        maxNumberOfMessages=10
);

writeDump(messages);
for (message in messages.data.receiveMessageResult) {
    writeDump(message.body);
    delete = request.prc.aws.sqs.deleteMessage(
        queueName=queueName,
        receiptHandle=message.receiptHandle
    );
    if (!delete.statuscode eq 200) {
        writeDump(delete);
    }
}


</cfscript>