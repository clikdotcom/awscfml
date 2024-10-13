<cfscript>
queueName = "testqueue8.fifo";

res = request.prc.aws.sqs.deleteQueue( queueName);
writeDump(res);
   


</cfscript>