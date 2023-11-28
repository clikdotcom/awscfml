<cfscript>
queueName = "testqueue7";

res = request.prc.aws.sqs.deleteQueue( queueName);
writeDump(res);
   


</cfscript>