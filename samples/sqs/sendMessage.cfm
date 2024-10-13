<cfscript>
queueName = "testqueue5";
message = "Simple text message";


try {
        throw("test error");
}
catch (any e) {
        message = serializeJSON(e);
}

timer type="inline" {
message = request.prc.aws.sqs.sendMessage(
        queueName=queueName,
        message=message
    );
}
writeDump(message);

</cfscript>