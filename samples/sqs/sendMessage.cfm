<cfscript>
queueName = "testqueue5";
message = "Simple text message";

message = request.prc.aws.sqs.sendMessage(
        queueName=queueName,
        message=message
    );
writeDump(message);

</cfscript>