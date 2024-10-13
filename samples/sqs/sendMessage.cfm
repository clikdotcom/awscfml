<cfscript>

fifo = 1;
queueName = "testqueue9";

messageArgs = {
	queueName = queueName,
	message = "Simple text message"
};


if (fifo) {
	messageArgs.queueName &= ".fifo";
	messageArgs.messageGroupId = "testGroup";
	messageArgs.messageDeduplicationId=createGUID();
}


try {
	throw("test error");
}
catch (any e) {
	messageArgs.message = serializeJSON(e);
}

timer type="inline" {
	message = request.prc.aws.sqs.sendMessage(argumentCollection = messageArgs);
}
writeDump(message);

</cfscript>