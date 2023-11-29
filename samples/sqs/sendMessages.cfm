<cfscript>
queueName = "testqueue5";
messages = [];

for (i = 1; i lte 10; i++) {
    messages.append({"message": "Message number #i#"});
}

message = request.prc.aws.sqs.sendMessageBatch(
        queueName=queueName,
        messages=messages
    );

writeDump(message);

</cfscript>