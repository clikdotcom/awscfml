<cfscript>
queues = request.prc.aws.sqs.listQueues();
writeDump(queues);

</cfscript>