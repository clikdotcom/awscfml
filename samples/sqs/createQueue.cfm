<cfscript>

queueName="testqueue7";

queue = request.prc.aws.sqs.createQueue(
    queueName=queueName,
    fifoQueue=0    
);

if (queue.statuscode eq 200) {
    writeDump(queue.data.createQueueResult.QueueUrl);
}
else {
    writeOutput("Create queue failed");
    writeDump(queue);
}

</cfscript>