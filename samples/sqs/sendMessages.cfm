<cfscript>

queueName = "testqueue9.fifo";
messages = [];

fifo = listLast(queueName,".") eq "fifo";

for (i = 1; i lte 10; i++) {

    messageData = {"text": "Message number #i#", "id" = createGUID()};

    message = {"message": serializeJSON(messageData)};
    if ( fifo ) {
        message["MessageGroupId"] = "testGroup";
        message["MessageDeduplicationId"] = createGUID();
    }
    messages.append( message);
}

message = request.prc.aws.sqs.sendMessageBatch(
    queueName=queueName,
    messages=messages
);

if (message.responseHeaders.status_code eq 200) {
    writeOutput("Sent ok");
}
else {
    writeDump(message);    
}


</cfscript>