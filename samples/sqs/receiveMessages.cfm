<cfscript>
queueName = "testqueue9.fifo";

messages = request.prc.aws.sqs.receiveMessage(
        queueName=queueName,
        maxNumberOfMessages=10
);

results = [];

if (! IsArray(messages.data.receiveMessageResult) ) {
    if ( IsStruct(messages.data.receiveMessageResult) && messages.data.receiveMessageResult.keyExists("message") ) {
        results = [messages.data.receiveMessageResult.message];
    }
}
else  {
    results = messages.data.receiveMessageResult;
}

if (! results.len() ) {
    writeOutput("No messages in queue");
}

for (message in results) {
    writeDump(deserializeJSON( message.body ) );
    delete = request.prc.aws.sqs.deleteMessage(
        queueName=queueName,
        receiptHandle=message.receiptHandle
    );
    if (!delete.statuscode eq 200) {
        writeDump(delete);
    }
}


</cfscript>