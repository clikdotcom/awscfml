<cfscript>

queue = {
    "queueName"="testqueue5",
    "fifoQueue" = 0
}

res = request.prc.aws.sqs.createQueue(
    argumentCollection = queue  
);

if (res.statuscode eq 200) {
    writeDump(res.data.createQueueResult.QueueUrl);
}
else {
    writeOutput("Create queue failed");
    writeDump(res);
}

if (queue.fifoQueue) {
    writeOutput("Remember queue will be called #queue.queueName#.fifo");
}

</cfscript>